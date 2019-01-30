import { Component, Input, OnChanges } from '@angular/core';
import { MeasureModel } from 'src/app/models/measure-model';
import { FormGroup, FormBuilder, FormArray, Validators } from '@angular/forms';
import { LandUseType } from 'src/app/models/enums/landuse-type';
import { VegetationModel } from '../../models/vegetation-model';

@Component({
  selector: 'gbp-measure',
  templateUrl: './measure-component.html',
  styleUrls: ['./menubar-component.scss', './measure-component.scss']
})

export class MeasureComponent implements OnChanges {

  @Input() public measureModels: MeasureModel[] = [];
  public measureForm: FormGroup;
  public openMeasure: number = 0;
  public landUseValues: any[];
  public activeMeasure: number = 0;
  private numberPattern: '^[0-9][0-9]?$|^100$';

  constructor(private fb: FormBuilder) {
    this.measureForm = this.constructForm(fb);
    this.landUseValues = Object.keys(LandUseType);
  }

  public constructForm(fb: FormBuilder): FormGroup {
    return fb.group({
      measures: fb.array([])
    });
  }

  public ngOnChanges(): void {
    const resetObject = {
      measures: this.fb.array([])
    };
    this.measureForm.reset(resetObject);
    this.setMeasures(this.measureModels);
    this.ensureOneMeasureExists();
    // this.cdRef.detectChanges();
  }

  public get measures(): FormArray {
    return this.measureForm.get('measures') as FormArray;
  }

  public onOpenMeasure(event: any) {
    if (this.openMeasure === event) {
      this.openMeasure = undefined;
    } else {
      this.openMeasure = event;
    }
  }

  public onDeleteClick() {
    // TODO
  }

  public saveClick(index: number) {
    this.saveMeasure(index);
  }

  public cancelClick(index: number) {
    this.measures.removeAt(index);
  }

  private saveMeasure(index: number) {
    this.activeMeasure = -1;
    const measureFormGroup = (this.measureForm.get('measures') as FormArray).controls[index] as FormGroup;
    const measureModel = this.fromFormGroupToModel(measureFormGroup);
    if (!this.measureModels) {
      this.measureModels = [];
    }
    this.measureModels.push(measureModel);
  }

  private setMeasures(measures: MeasureModel[]) {
    if (measures) {
      const measureFormArray = this.fb.array(measures.map((measure) => this.fromModelToFormGroup(measure)));
      this.measureForm.setControl('measures', measureFormArray);
    }
  }

  private fromFormGroupToModel(measureFG: FormGroup): MeasureModel {
    const measureFormModel = measureFG.value;

    const measureModel: MeasureModel = {
      measureId: measureFormModel.id,
      measureName: measureFormModel.name,
      landuse: measureFormModel.landuse,
      vegetation: measureFormModel.vegetation,
      inhabitants: measureFormModel.inhabitants,
      woz: measureFormModel.woz
    };

    return measureModel;
  }

  private fromModelToFormGroup(measure: MeasureModel): FormGroup {
    return this.fb.group({
      id: measure.measureId,
      name: [measure.measureName, Validators.required],
      landuse: measure.landuse,
      vegetation: this.fb.group({
        low: [measure.vegetation.low, Validators.pattern(this.numberPattern)],
        middle: [measure.vegetation.middle, Validators.pattern(this.numberPattern)],
        high: [measure.vegetation.high, Validators.pattern(this.numberPattern)]
      }),
      inhabitants: measure.inhabitants,
      woz: measure.woz
    });
  }

  private ensureOneMeasureExists() {
    if (this.measures.length === 0) {
      this.addNewMeasure();
    }
  }

  private addNewMeasure() {
    const newModel = new MeasureModel();
    newModel.measureId = -1;
    newModel.vegetation = new VegetationModel();
    this.addMeasure(newModel);
  }

  private addMeasure(measure: MeasureModel) {
    const measureFG = this.fromModelToFormGroup(measure);
    const formArray = this.measureForm.get('measures') as FormArray;
    formArray.push(measureFG);
  }
}
