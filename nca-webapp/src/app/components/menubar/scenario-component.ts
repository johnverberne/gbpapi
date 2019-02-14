import { Component, OnInit, ViewChild, OnChanges, ChangeDetectorRef } from '@angular/core';
import { CurrentProjectService } from 'src/app/services/current-project-service';
import { ScenarioModel } from 'src/app/models/scenario-model';
import { FormGroup, FormBuilder, FormControl } from '@angular/forms';
import { CalculationService } from '../../services/calculation-service';
import { AssessmentRequest } from '../../models/assessment-request-model';
import { MenuEventService } from '../../services/menu-event-service';
import { MeasureComponent } from './measure-component';

@Component({
  selector: 'gbp-scenario',
  templateUrl: './scenario-component.html',
  styleUrls: ['./menubar-component.scss', './scenario-component.scss']
})
export class ScenarioComponent implements OnInit {

  @ViewChild(MeasureComponent) private gbpMeasures: MeasureComponent;

  public MAX_SCENARIO_THRESHOLD: number = 4;
  public currentScenarioIndex: number = 0;
  public currentScenario: ScenarioModel;
  public scenarioForm: FormGroup;

  constructor(private fb: FormBuilder,
    public cdRef: ChangeDetectorRef,
    public projectService: CurrentProjectService,
    private calculationService: CalculationService,
    private menuService: MenuEventService) {
    this.scenarioForm = this.constructForm(this.fb);
  }

  public ngOnInit(): void {
    if (this.scenarios.length === 0) {
      this.addScenario();
    }
  }

  public updateScenarioForm(): void {
    const resetObject = {
      id: this.currentScenario.scenarioId,
      name: this.currentScenario.scenarioName
    };
    this.scenarioForm.reset(resetObject);
    this.cdRef.detectChanges();
  }

  public constructForm(fb: FormBuilder): FormGroup {
    return fb.group({
      id: new FormControl(),
      name: new FormControl(),
      measures: MeasureComponent.constructForm(this.fb)
    });
  }

  public get scenarios() {
    if (this.projectService.currentProject.scenarios) {
      return this.projectService.currentProject.scenarios;
    }
  }

  public get measures() {
    if (this.scenarios[this.currentScenarioIndex]) {
      return this.scenarios[this.currentScenarioIndex].measures;
    }
  }

  public addScenario() {
    if (this.scenarios.length < this.MAX_SCENARIO_THRESHOLD) {
      this.scenarios.push(new ScenarioModel());
      this.currentScenarioIndex = this.scenarios.length - 1;
      this.currentScenario = this.scenarios[this.currentScenarioIndex];
      this.scenarioForm = this.constructForm(this.fb);
      this.updateScenarioForm();
      this.menuService.scenarioChange();
    }
  }

  public onScenarioClick(scenario: ScenarioModel, index: number) {
    this.currentScenarioIndex = index;
    this.currentScenario = scenario;
    this.menuService.scenarioChange();
    this.updateScenarioForm();
  }

  public onDeleteClick() {
    this.scenarios.splice(this.currentScenarioIndex, 1);
    this.currentScenarioIndex = this.currentScenarioIndex - 1;
    if (this.currentScenarioIndex < 0) {
      this.currentScenarioIndex = 0;
    }
    this.updateScenarioForm();
    this.ensureOneScenarioExists();
  }

  public hasMeasures(): boolean {
    return this.scenarios[this.currentScenarioIndex].measures.length > 0;
  }

  public calculateClick(index: number) {
    const request = new AssessmentRequest();
    request.name = 'Test scenario Geert';
    request.eco_system_service = 'AIR_REGULATION';
    this.calculationService.startCalculation(request).subscribe((result) => {
      if (result) {
        this.projectService.currentProject.results = result;
        console.log('Result: ' + result.successful);
      }
    });
  }

  public saveClick() {
    if (this.scenarioForm.valid) {
      const name = this.scenarioForm.get('name').value;
      this.scenarios[this.currentScenarioIndex].scenarioName = name;
      this.scenarios[this.currentScenarioIndex].measures = this.gbpMeasures.saveMeasures();
    }
  }

  public cancelClick(index: number) {
    // TODO needs to be defined by Taco
  }

  private ensureOneScenarioExists() {
    if (this.scenarios.length === 0) {
      this.scenarios.push(new ScenarioModel());
    }
  }
}
