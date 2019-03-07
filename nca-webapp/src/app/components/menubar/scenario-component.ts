import { Component, OnInit, ViewChild, OnChanges, ChangeDetectorRef, Input } from '@angular/core';
import { CurrentProjectService } from 'src/app/services/current-project-service';
import { ScenarioModel } from 'src/app/models/scenario-model';
import { FormGroup, FormBuilder, FormControl } from '@angular/forms';
import { CalculationService } from '../../services/calculation-service';
import { AssessmentRequest } from '../../models/assessment-request-model';
import { MeasureComponent } from './measure-component';
import { TranslateService } from '@ngx-translate/core';
import { MenuEventService } from '../../services/menu-event-service';
import { ProjectModel } from '../../models/project-model';

@Component({
  selector: 'gbp-scenario',
  templateUrl: './scenario-component.html',
  styleUrls: ['./menubar-component.scss', './scenario-component.scss']
})
export class ScenarioComponent implements OnChanges {

  @ViewChild(MeasureComponent) private gbpMeasures: MeasureComponent;
  @Input() public scenarioModel: ScenarioModel;
  public scenarioForm: FormGroup;

  constructor(private fb: FormBuilder,
    public cdRef: ChangeDetectorRef,
    public projectService: CurrentProjectService,
    private calculationService: CalculationService,
    private translateService: TranslateService) {
    this.scenarioForm = this.constructForm(this.fb);
  }

  public ngOnChanges(): void {
    const resetObject = {
      id: this.scenarioModel.scenarioId,
      name: this.scenarioModel.scenarioName,
      measures: MeasureComponent.constructForm(this.fb)
    };
    this.scenarioForm.reset(resetObject);
    if (this.cdRef) {
      this.cdRef.detectChanges();
    }
  }

  public constructForm(fb: FormBuilder): FormGroup {
    return fb.group({
      id: '',
      name: '',
      measures: MeasureComponent.constructForm(this.fb)
    });
  }

  public get measures() {
    if (this.scenarioModel) {
      return this.scenarioModel.measures;
    }
  }

  public calculateClick() {
    const request = new AssessmentRequest();
    request.name = 'Test scenario Geert';
    request.eco_system_service = 'AIR_REGULATION';
    this.calculationService.startCalculation(request).subscribe(
      (result) => {
        if (result) {
          this.scenarioModel.results = result;
          console.log('Result: ' + result.successful);
        }
      },
      (error) => {
        this.scenarioModel.results = error;
      }
    );
  }

  public saveClick() {
    if (this.scenarioForm.valid) {
      const name = this.scenarioForm.get('name').value;
      this.scenarioModel.scenarioName = name;
      this.scenarioModel.measures = this.gbpMeasures.saveMeasures();
      this.scenarioModel.valid = true;
    }
    console.log(JSON.stringify(this.projectService.currentProject as ProjectModel));
  }

  public cancelClick() {
    this.gbpMeasures.ngOnChanges();
    this.ngOnChanges();
  }

  public hasMeasures() {
    return this.gbpMeasures.measures.length > 0;
  }

  public isValidScenario() {
    return this.scenarioModel.valid;
  }

}
