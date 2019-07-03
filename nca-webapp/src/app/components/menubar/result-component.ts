import { Component, OnInit } from '@angular/core';
import { CurrentProjectService } from 'src/app/services/current-project-service';
import { Router } from '@angular/router';
import { MenuEventService } from '../../services/menu-event-service';
import { MeasureModel } from '../../models/measure-model';
import { MessageEventService } from '../../services/message-event-service';
import { ResultType } from '../../models/enums/result-type';
import { MapService } from '../../services/map-service';
import { LandUseType } from '../../models/enums/landuse-type';
import { EnumUtils } from '../../shared/enum-utils';

@Component({
  selector: 'gbp-result',
  templateUrl: './result-component.html',
  styleUrls: ['./menubar-component.scss', './result-component.scss']
})
export class ResultComponent implements OnInit {

  public MAX_SCENARIO_THRESHOLD: number = 4;
  public openMenu: boolean = true;
  public currentScenarioIndex: number = 0;
  public resultType: ResultType = ResultType.PHYSICAL;
  public landUseValues = new Map();

  constructor(public projectService: CurrentProjectService,
    public router: Router,
    private menuEventService: MenuEventService,
    private messageEventService: MessageEventService,
    private mapService: MapService) {
      this.landUseValues = EnumUtils.toMap(LandUseType);
      this.menuEventService.onMenuCollapse().subscribe((collapse) => {
        this.openMenu = collapse;
      });
      this.menuEventService.onShowResultMap().subscribe(() => this.drawResults());
  }

  public ngOnInit() {
    this.drawResults();
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
    this.menuEventService.scenarioChange(index);
    this.drawResults();
  }

  private drawResults() {
    this.mapService.clearMap();
    this.mapService.showResults(true, this.scenario.key, 'potUHI-actual_change');
  }

}
