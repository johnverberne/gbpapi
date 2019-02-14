import { Component, Input, OnChanges, Output, EventEmitter, ChangeDetectorRef, OnInit } from '@angular/core';
import { MeasureModel } from '../../models/measure-model';
import { FormGroup, FormBuilder, FormArray, Validators } from '@angular/forms';
import { LandUseType } from '../../models/enums/landuse-type';
import { VegetationModel } from '../../models/vegetation-model';
import { MapService } from '../../services/map-service';
import { Subscription } from 'rxjs';
import { MenuEventService } from '../../services/menu-event-service';

@Component({
  selector: 'gbp-measure',
  templateUrl: './measure-component.html',
  styleUrls: ['./menubar-component.scss', './measure-component.scss']
})

export class MeasureComponent implements OnChanges {

  @Input() public measureForm: FormGroup;
  @Input() public measureModels: MeasureModel[] = [];
  @Output() public measureModelsChange = new EventEmitter<MeasureModel[]>();

  public MAX_MEASURES_THRESHOLD: number = 4;

  public openMeasure: number = -1;
  public isOpen: boolean = true;
  public landUseValues: any[];
  public validated: boolean = false;
  private numberPattern: '^[0-9][0-9]?$|^100$';
  private colors: string[] = ['#D63327', '#93278F', '#1C0078', '#FF931E'];
  private coordinatesPerMeasure: number[][][] = [];
  private featureSubsciption: Subscription;

  constructor(private fb: FormBuilder,
    private cdRef: ChangeDetectorRef,
    private mapService: MapService,
    private menuService: MenuEventService) {
      this.landUseValues = Object.keys(LandUseType);
      this.menuService.onScenarioChange().subscribe(() => this.manageDrawing());
      this.menuService.onMainMenuChange().subscribe(() => this.disableDrawForMeasure());
  }

  public static constructForm(fb: FormBuilder): FormGroup {
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
    this.cdRef.detectChanges();
  }

  public get measures(): FormArray {
    return this.measureForm.get('measures') as FormArray;
  }

  public getColor(index?: number): string {
    if (index !== undefined) {
      return this.colors[index];
    } else {
      return this.colors[this.measures.length];
    }
  }

  public onOpenMeasure(event: number) {
    if (this.openMeasure === event) {
      this.isOpen = !this.isOpen;
      if (this.isOpen) {
        this.enableDrawForMeasure();
      } else {
        this.disableDrawForMeasure();
        this.openMeasure = -1;
      }
    } else {
      this.isOpen = true;
      this.openMeasure = event;
      this.enableDrawForMeasure();
    }
  }

  public onDeleteClick(index: number) {
    this.measures.removeAt(index);
    this.measureModels.splice(index, 1);
    this.measureForm.markAsDirty();
    this.openMeasure = -1;
    this.measureModelsChange.emit(this.measureModels);
  }

  public onAddMeasureClick() {
    if (this.measures.length < this.MAX_MEASURES_THRESHOLD) {
      this.addNewMeasure();
      this.openMeasure = this.measures.length - 1;
      this.isOpen = true;
      this.manageDrawing();
    }
  }

  public saveMeasures(): MeasureModel[] {
    this.validated = true;
    if (this.measureForm.valid) {
      this.openMeasure = -1;
      const measures: MeasureModel[] = [];
      for (const index in this.measures.controls) {
        if (this.measures.controls[index] instanceof FormGroup) {
        const measureFormGroup = this.measures.controls[index] as FormGroup;
        const measureModel = this.fromFormGroupToModel(measureFormGroup);
        measures.push(measureModel);
        }
      }
      this.validated = false;
      this.disableDrawForMeasure();
      return measures;
    }
  }

  private manageDrawing() {
    if (this.featureSubsciption) {
      this.disableDrawForMeasure();
    }
    this.enableDrawForMeasure();
  }

  private enableDrawForMeasure() {
    let measureCoordinates;
    if (this.openMeasure === -1) {
      const length = this.coordinatesPerMeasure.push([]);
      measureCoordinates = this.coordinatesPerMeasure[length - 1];
    } else {
      measureCoordinates = this.coordinatesPerMeasure[this.openMeasure];
    }
    this.mapService.startDrawing( measureCoordinates );
    this.featureSubsciption = this.mapService.onFeatureDrawn().subscribe(() => this.addFeatures(measureCoordinates));
  }

  private disableDrawForMeasure() {
    this.mapService.stopDrawing();
    this.featureSubsciption.unsubscribe();
  }

  private setMeasures(measures: MeasureModel[]) {
    if (measures) {
      this.coordinatesPerMeasure = [];
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
      woz: measureFormModel.woz,
      cells: []
    };

    return measureModel;
  }

  private fromModelToFormGroup(measure: MeasureModel): FormGroup {
    this.coordinatesPerMeasure.push(measure.cells);
    return this.fb.group({
      id: measure.measureId,
      name: [measure.measureName, Validators.required],
      landuse: [measure.landuse, Validators.required],
      vegetation: this.fb.group({
        low: [measure.vegetation.low, Validators.pattern(this.numberPattern)],
        middle: [measure.vegetation.middle, Validators.pattern(this.numberPattern)],
        high: [measure.vegetation.high, Validators.pattern(this.numberPattern)]
      }),
      inhabitants: measure.inhabitants,
      woz: measure.woz
    });
  }

  private addFeatures(coordinates: number[]) {
    if (this.openMeasure === -1) {
      this.addNewMeasure();
      this.openMeasure = this.measures.length - 1;
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
