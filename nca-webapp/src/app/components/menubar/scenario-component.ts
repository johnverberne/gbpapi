import { Component } from '@angular/core';
import { CurrentProjectService } from 'src/app/services/current-project-service';
import { ScenarioModel } from 'src/app/models/scenario-model';

@Component({
  selector: 'gbp-scenario',
  templateUrl: './scenario-component.html',
  styleUrls: ['./menubar-component.scss', './scenario-component.scss']
})
export class ScenarioComponent {

  public MAX_SCENARIO_THRESHOLD: number = 5;
  public currentScenario: number = 0;

  constructor(public projectService: CurrentProjectService) {
    this.addScenario();
  }

  public addScenario() {
    if (this.projectService.currentProject.scenarios.length < this.MAX_SCENARIO_THRESHOLD) {
      this.projectService.currentProject.scenarios.push(new ScenarioModel());
    }
  }

  public onScenarioClick(scenario: ScenarioModel, index: number) {
    this.currentScenario = index;
  }

  public onDeleteClick() {
    this.projectService.currentProject.scenarios.splice(this.currentScenario, 1);
  }
}
