import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CurrentProjectService } from 'src/app/services/current-project-service';
import { ScenarioModel } from 'src/app/models/scenario-model';
import { MenuEventService } from '../../services/menu-event-service';
import { TranslateService } from '@ngx-translate/core';
import { CalculationService } from '../../services/calculation-service';
import { AssessmentRequestModel } from '../../models/assessment-request-model';
import { ScenarioRequestModel } from '../../models/scenario-request-model';
import { LayerModel } from '../../models/layer-model';
import { MeasureModel } from '../../models/measure-model';
import { CalculationEventService } from '../../services/calculation-event-serivce';
import { Router } from '@angular/router';
import { GridCellModel } from '../../models/grid-cell-model';

@Component({
  selector: 'gbp-scenario-list',
  templateUrl: './scenario-list-component.html',
  styleUrls: ['./menubar-component.scss', './scenario-list-component.scss']
})
export class ScenarioListComponent implements OnInit {

  public MAX_SCENARIO_THRESHOLD: number = 4;
  public currentScenarioIndex: number = 0;
  public currentScenario: ScenarioModel;

  constructor(public cdRef: ChangeDetectorRef,
    public projectService: CurrentProjectService,
    private menuService: MenuEventService,
    private calculationService: CalculationService,
    private translateService: TranslateService,
    private calculationEventService: CalculationEventService,
    private router: Router) {
  }

  public ngOnInit(): void {
    if (this.scenarios.length === 0) {
      this.addScenario();
    }
    this.currentScenario = this.scenarios[this.currentScenarioIndex];
  }

  public get scenarios() {
    if (this.projectService.currentProject.scenarios) {
      return this.projectService.currentProject.scenarios;
    }
  }

  public onAddScenarioClick() {
    this.addScenario();
    this.currentScenarioIndex = this.scenarios.length - 1;
    this.currentScenario = this.scenarios[this.currentScenarioIndex];
    this.menuService.scenarioChange(this.currentScenarioIndex);
  }

  public addScenario() {
    if (this.scenarios.length < this.MAX_SCENARIO_THRESHOLD) {
      const scenario = new ScenarioModel();
      scenario.scenarioName = this.translateService.instant('SCENARIO') + ' ' + (this.scenarios.length + 1);
      this.scenarios.push(scenario);
    }
  }

  public onScenarioClick(scenario: ScenarioModel, index: number) {
    this.currentScenarioIndex = index;
    this.currentScenario = scenario;
    this.menuService.scenarioChange(index);
  }

  public onDeleteClick() {
    this.scenarios.splice(this.currentScenarioIndex, 1);
    this.currentScenarioIndex = this.currentScenarioIndex - 1;
    if (this.currentScenarioIndex < 0) {
      this.currentScenarioIndex = 0;
    }
    this.ensureOneScenarioExists();
  }

  public calculateClick() {
    let modelData;
    this.calculationService.getModelData('AIR_REGULATION'.toLowerCase()).subscribe(
      (model) => {
        modelData = model;
        const request = this.createScenarioRequest(modelData);
        this.calculationEventService.calculationStarted();
        this.calculationService.startImmediateScenarioCalculation(request).subscribe(
          (result) => {
            if (result) {
              if (result.errors) {
                result.errors.forEach(error => console.log('Back-end error: ' + error.message));
              }
              if (result.warnings) {
                result.warnings.forEach(warning => console.log('Back-end warning: ' + warning.message));
              }
              if (result.successful && result.assessmentResults) {
                this.scenarios.forEach((scenario, index) => {
                  scenario.results = result.assessmentResults[index].entries;
                });
              }
            }
            this.calculationEventService.calculationFinished();
            this.router.navigate([{ outlets: { primary: 'result', main: 'map' }}]);
          },
          (error) => {
            this.calculationEventService.calculationFinished();
            // this.scenarioModel.results = error;
          }
        );
      }
    );


  }

  private createScenarioRequest(modelData: any) {
    const request = [];
    this.scenarios.forEach(scenario => {
      const scenarioRequest = new ScenarioRequestModel();
      scenario.measures.forEach(measure => {
        const measureRequest = new AssessmentRequestModel();
        measureRequest.name = scenario.scenarioName + ' - ' + measure.measureName;
        measureRequest.model = 'NKMODEL2';
        measureRequest.eco_system_service = 'AIR_REGULATION'.toLowerCase();
        this.defineExtent(measure, measureRequest);
        modelData.entries.forEach(model => {
          const layer = new LayerModel();
          layer.classType = model;
          layer.dataType = 'XYZ';
          layer.data = this.processCellData(measure, model);
          measureRequest.layers.push(layer);
        });
        scenarioRequest.measures.push(measureRequest);
      });
      request.push(scenarioRequest);
    });
    return request;
  }

  private defineExtent(measure: MeasureModel, measureRequest: AssessmentRequestModel) {
    measure.geom.cells.sort(this.compare);
    let start = measure.geom.cells[0].coordsAfrt;
    start = start.map(coord => coord - 1000);
    let end = measure.geom.cells[measure.geom.cells.length - 1].coordsAfrt;
    end = end.map(coord => coord + 1000);
    measureRequest.extent.push(start);
    measureRequest.extent.push(end);
  }

  public areScenariosValid() {
    const scenarios = this.scenarios.filter(scenario => scenario.valid);
    return scenarios.length === this.scenarios.length;
  }

  private processCellData(measure: MeasureModel, model: string) {
    let data: string[];
    let value = 0;
    switch (model) {
      case 'POPULATION': {
        value = measure.geom.cells.length > 0 ? measure.inhabitants / measure.geom.cells.length : 0;
        break;
      }
      case 'TREES': {
        value = measure.vegetation.high / 100;
        break;
      }
      case 'SHRUBS': {
        value = measure.vegetation.middle / 100;
        break;
      }
      case 'GRASS': {
        value = measure.vegetation.low / 100;
        break;
      }
      case 'WOZ': {
        value = measure.woz;
        break;
      }
      case 'LAND_COVER': {
        value = measure.landuse;
        break;
      }
    }
    measure.geom.cells.sort(this.compare);
    data = measure.geom.cells.map(cells => {
      return cells.coordsAfrt[0] + ' ' + cells.coordsAfrt[1] + ' ' + value;
    });


    const encodedData = window.btoa(data.join('\n'));
    return encodedData;
  }

  private ensureOneScenarioExists() {
    if (this.scenarios.length === 0) {
      this.scenarios.push(new ScenarioModel());
    }
  }

  private compare(a: GridCellModel, b: GridCellModel) {
    return a.coordsAfrt[1] === b.coordsAfrt[1] ? a.coordsAfrt[0] - b.coordsAfrt[0] : a.coordsAfrt[1] - b.coordsAfrt[1];
  }
}
