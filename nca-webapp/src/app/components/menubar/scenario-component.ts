import { Component } from '@angular/core';
import { CurrentProjectService } from 'src/app/services/current-project-service';
import { ScenarioModel } from 'src/app/models/scenario-model';
import { FormGroup, FormBuilder, FormControl } from '@angular/forms';
import { MeasureModel } from '../../models/measure-model';
import { CalculationService } from '../../services/calculation-service';
import { AssessmentRequest } from '../../models/assessment-request-model';

@Component({
  selector: 'gbp-scenario',
  templateUrl: './scenario-component.html',
  styleUrls: ['./menubar-component.scss', './scenario-component.scss']
})
export class ScenarioComponent {

  public MAX_SCENARIO_THRESHOLD: number = 5;
  public currentScenario: number = 0;
  public scenarioForm: FormGroup;
  public debug: boolean = true;

  constructor(private fb: FormBuilder, public projectService: CurrentProjectService, private calculationService: CalculationService) {
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

  public hasMeasures(): boolean {
    return this.projectService.currentProject.scenarios[this.currentScenario].measures.length > 0;
  }

  public onAddMeasureClick() {
    this.projectService.currentProject.scenarios[this.currentScenario].measures.push(new MeasureModel());
  }

  public calculateClick(index: number) {
    const request = new AssessmentRequest();
    request.name = 'Test scenario Geert';
    request.eco_system_service = 'AIR_REGULATION';
    this.calculationService.startCalculation(request).subscribe((result) => {
      if (result) {
        console.log('Result: ' + result.successful);
      }
    });
  }
}
