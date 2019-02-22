import { Component } from '@angular/core';
import { CurrentProjectService } from 'src/app/services/current-project-service';
import { Router } from '@angular/router';
import { MenuEventService } from '../../services/menu-event-service';
import { MeasureModel } from '../../models/measure-model';
import { MessageEventService } from '../../services/message-event-service';
import { ScenarioModel } from '../../models/scenario-model';
import { FeatureModel } from '../../models/feature-model';
import { LandUseType } from '../../models/enums/landuse-type';
import { VegetationModel } from '../../models/vegetation-model';

@Component({
  selector: 'gbp-result',
  templateUrl: './result-component.html',
  styleUrls: ['./menubar-component.scss', './result-component.scss']
})
export class ResultComponent {

  public MAX_SCENARIO_THRESHOLD: number = 4;
  public openMenu: boolean = true;
  public currentScenarioIndex: number = 0;

  constructor(public projectService: CurrentProjectService,
    public router: Router,
    private menuEventService: MenuEventService,
    private messageEventService: MessageEventService) {
    this.menuEventService.onMenuCollapse().subscribe((collapse) => {
      this.openMenu = collapse;
    });
  }

  public get measures() {
    if (this.projectService.currentProject.scenarios[this.currentScenarioIndex]) {
      return this.projectService.currentProject.scenarios[this.currentScenarioIndex].measures;
    }
  }

  public get scenario() {
    if (this.projectService.currentProject.scenarios) {
      return this.projectService.currentProject.scenarios[this.currentScenarioIndex];
    }
  }

  public get scenarios() {
    if (this.projectService.currentProject.scenarios) {
      return this.projectService.currentProject.scenarios;
    }
  }

  public getMeasureSize(measure: MeasureModel) {
    return measure.geom.cells.length;
  }

  public exportClick() {
    this.messageEventService.sendMessage('WIP');
  }

  public onScenarioClick(index: number) {
    this.currentScenarioIndex = index;
  }

}
