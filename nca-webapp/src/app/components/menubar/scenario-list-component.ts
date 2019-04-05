import { Component, OnInit, ChangeDetectorRef, OnChanges } from '@angular/core';
import { CurrentProjectService } from 'src/app/services/current-project-service';
import { ScenarioModel } from 'src/app/models/scenario-model';
import { MenuEventService } from '../../services/menu-event-service';
import { TranslateService } from '@ngx-translate/core';
import { CalculationService } from '../../services/calculation-service';
import { AssessmentRequestModel } from '../../models/assessment-request-model';
import { ScenarioRequestModel } from '../../models/scenario-request-model';
import { LayerModel } from '../../models/layer-model';
import { MeasureModel } from '../../models/measure-model';

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
    private translateService: TranslateService) {
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
        this.calculationService.startImmediateScenarioCalculation(request).subscribe(
          (result) => {
            if (result) {
              if (result.errors) {
                result.errors.forEach(error => console.log('Back-end error: ' + error.message));
              }
              if (result.warnings) {
                result.warnings.forEach(warning => console.log('Back-end warning: ' + warning.message));
              }
              //this.scenarioModel.results = result.assessmentResults;
              if (result.assessmentResults) {
                console.log('Result: ' + result.assessmentResults);
              }
            }
          },
          (error) => {
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
        measureRequest.model = 'NKMODEL';
        measureRequest.eco_system_service = 'AIR_REGULATION'.toLowerCase();
        modelData.entries.forEach(model => {
          const layer = new LayerModel();
          layer.classType = model;
          layer.dataType = 'XYZ';
          layer.data = this.processCellData(measure, model);
          measureRequest.layers.push();
        });
        scenarioRequest.measures.push(measureRequest);
      });
      request.push(scenarioRequest);
    });
    return request;
  }

  public areScenariosValid() {
    const scenarios = this.scenarios.filter(scenario => scenario.valid);
    return scenarios.length === this.scenarios.length;
  }

  private processCellData(measure: MeasureModel, model: string) {
    let data;
    let value;
    switch (model) {
      case 'POPULATION': {
        value = measure.geom.cells.length > 0 ? measure.inhabitants / measure.geom.cells.length : 0;
        break;
      }
      case 'TREES': {
        value = measure.vegetation.high;
        break;
      }
      case 'SHRUBS': {
        value = measure.vegetation.middle;
        break;
      }
      case 'GRASS': {
        value = measure.vegetation.low;
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
    data = measure.geom.cells.map(cells => {
      return cells.coords[0] + ' ' + cells.coords[1] + ' ' + value;
    });
    const blob = new Blob([data], {type : 'text/plain'});
    return blob;
  }

  private ensureOneScenarioExists() {
    if (this.scenarios.length === 0) {
      this.scenarios.push(new ScenarioModel());
    }
  }
}
