import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CurrentProjectService } from 'src/app/services/current-project-service';
import { ScenarioModel } from 'src/app/models/scenario-model';
import { MenuEventService } from '../../services/menu-event-service';
import { TranslateService } from '@ngx-translate/core';

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
    private translateService: TranslateService) {
  }

  public ngOnInit(): void {
    if (this.scenarios.length === 0) {
      this.addScenario();
      this.currentScenario = this.scenarios[this.currentScenarioIndex];
    }
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
    this.menuService.scenarioChange();
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
    this.menuService.scenarioChange();
  }

  public onDeleteClick() {
    this.scenarios.splice(this.currentScenarioIndex, 1);
    this.currentScenarioIndex = this.currentScenarioIndex - 1;
    if (this.currentScenarioIndex < 0) {
      this.currentScenarioIndex = 0;
    }
    this.ensureOneScenarioExists();
  }

  private ensureOneScenarioExists() {
    if (this.scenarios.length === 0) {
      this.scenarios.push(new ScenarioModel());
    }
  }
}
