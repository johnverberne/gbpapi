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
import { CalculationEventService } from '../../services/calculation-event-service';
import { Router } from '@angular/router';
import { GridCellModel } from '../../models/grid-cell-model';
import { MessageEventService } from '../../services/message-event-service';
import { isNullOrUndefined } from 'util';

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
    private messageService: MessageEventService,
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
        this.calculationService.startScenarioCalculation(request).subscribe(
          (result) => {
            this.calculationEventService.calculationFinished();
            if (result) {
              if (result.errors && result.errors.length > 0) {
                result.errors.forEach(error => console.log('Back-end error: ' + error.message));
                this.messageService.sendMessage('ERROR_CALCULATION');
              }
              if (result.warnings && result.warnings.length > 0) {
                result.warnings.forEach(warning => console.log('Back-end warning: ' + warning.message));
              }
              if (result.successful && result.assessmentResults) {
                this.scenarios.forEach((scenario, index) => {
                  scenario.results = result.assessmentResults[index].entries;
                  scenario.url = result.assessmentResults[index].url;
                  scenario.key = result.assessmentResults[index].key;
                });
                this.router.navigate([{ outlets: { primary: 'result', main: 'table' } }]);
              }
            }
          },
          (error) => {
            this.calculationEventService.calculationFinished();
          }
        );
      }
    );
  }

  private createScenarioRequest(modelData: any) {
    const request = [];
    this.scenarios.forEach(scenario => {
      const scenarioRequest = new ScenarioRequestModel();
      const layers: LayerModel[] = [];
      const measureRequest = new AssessmentRequestModel();
      measureRequest.name = scenario.scenarioName;
      measureRequest.model = 'NKMODEL2';
      measureRequest.eco_system_service = 'AIR_REGULATION'.toLowerCase();
      scenario.measures.forEach(measure => {
        modelData.entries.forEach(model => {
          const layer = this.getLayer(layers, model);
          layer.data.push(...this.processCellData(measure, model));
        });
      });
      this.encodeCellData(layers);
      this.defineExtent(scenario, measureRequest);
      measureRequest.layers = layers;
      scenarioRequest.measures.push(measureRequest);
      request.push(scenarioRequest);
    });
    return request;
  }

  private getLayer(layers: any[], model: string): LayerModel {
    const index = layers.findIndex(layer => layer.classType === model);
    if (index === -1) {
      const layer = new LayerModel();
      layer.classType = model;
      layer.dataType = 'XYZ';
      layer.data = [];
      const length = layers.push(layer);
      return layers[length - 1];
    } else {
      return layers[index];
    }
  }

  private defineExtent(scenario: ScenarioModel, measureRequest: AssessmentRequestModel) {
    const cells: GridCellModel[] = [];
    scenario.measures.forEach(measure => {
      cells.push(...measure.geom.cells);
    });
    const allX = cells.map(cell => cell.coords[0]);
    const allY = cells.map(cell => cell.coords[1]);

    const start = [Math.min(...allX) - 1000, Math.min(...allY) - 1000];
    const end = [Math.max(...allX) + 1000, Math.max(...allY) + 1000];
    measureRequest.extent.push(start);
    measureRequest.extent.push(end);
  }

  public areScenariosValid() {
    const scenarios = this.scenarios.filter(scenario => scenario.measures && scenario.measures.length > 0);
    return scenarios.length === this.scenarios.length;
  }

  private encodeCellData(layers: LayerModel[]) {
    layers.forEach(layer => layer.data = window.btoa(layer.data.join('\n')));
  }

  private processCellData(measure: MeasureModel, model: string) {
    let data: string[];
    let value: number;
    switch (model) {
      case 'POPULATION': {
        if (measure.inhabitants) {
          value = measure.geom.cells.length > 0 ? measure.inhabitants / measure.geom.cells.length : null;
        }
        break;
      }
      case 'TREES': {
        if (measure.vegetation.high) {
          value = measure.vegetation.high / 100;
        }
        break;
      }
      case 'SHRUBS': {
        if (measure.vegetation.middle) {
          value = measure.vegetation.middle / 100;
        }
        break;
      }
      case 'GRASS': {
        if (measure.vegetation.low) {
          value = measure.vegetation.low / 100;
        }
        break;
      }
      case 'WOZ': {
        if (measure.woz) {
          value = measure.woz;
        }
        break;
      }
      case 'LAND_COVER': {
        if (measure.landuse) {
          value = measure.landuse;
        }
        break;
      }
    }
    if (isNullOrUndefined(value)) {
      return;
    }
    measure.geom.cells.sort(this.compare);
    data = measure.geom.cells.map(cells => {
      return cells.coords[0] + ' ' + cells.coords[1] + ' ' + value;
    });
    return data;
  }

  private ensureOneScenarioExists() {
    if (this.scenarios.length === 0) {
      this.scenarios.push(new ScenarioModel());
    }
  }

  private compare(a: GridCellModel, b: GridCellModel) {
    return a.coords[1] === b.coords[1] ? a.coords[0] - b.coords[0] : a.coords[1] - b.coords[1];
  }
}
