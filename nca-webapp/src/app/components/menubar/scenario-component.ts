import { Component } from '@angular/core';
import { CurrentProjectService } from 'src/app/services/current-project-service';
import { ScenarioModel } from 'src/app/models/scenario-model';
import { FormGroup, FormBuilder, FormControl } from '@angular/forms';

@Component({
  selector: 'gbp-scenario',
  templateUrl: './scenario-component.html',
  styleUrls: ['./menubar-component.scss', './scenario-component.scss']
})
export class ScenarioComponent {

  public MAX_SCENARIO_THRESHOLD: number = 5;
  public currentScenario: number = 0;
  public scenarioForm: FormGroup;

  constructor(private fb: FormBuilder, public projectService: CurrentProjectService) {
    this.scenarioForm = this.constructForm(fb);
    this.addScenario();
  }

  public constructForm(fb: FormBuilder): FormGroup {
    return fb.group({
      id: new FormControl(),
      name: new FormControl()
    });
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
