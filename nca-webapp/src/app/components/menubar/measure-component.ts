import { Component, Input, OnChanges, Output, EventEmitter, ChangeDetectorRef } from '@angular/core';
import { MeasureModel } from '../../models/measure-model';
import { FormGroup, FormBuilder, FormArray, Validators } from '@angular/forms';
import { LandUseType } from '../../models/enums/landuse-type';
import { MapService } from '../../services/map-service';
import { Subscription } from 'rxjs';
import { MenuEventService } from '../../services/menu-event-service';
import { FeatureModel } from '../../models/feature-model';
import { TranslateService } from '@ngx-translate/core';
import { MessageEventService } from '../../services/message-event-service';
import { MeasureStyles } from '../map/openlayers/measure-styles';
import { EnumUtils } from '../../shared/enum-utils';
import { GridCellModel } from '../../models/grid-cell-model';

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
  public landUseValues: Map<number, string>;
  public validated: boolean = false;
  public addMeasureColor: string;
  private numberPattern: '^[0-9][0-9]?$|^100$';
  private styles: string[] = Array.from(MeasureStyles.measureStyles.keys());
  private geomPerMeasure: FeatureModel[] = [];
  private featureSubsciption: Subscription;

  constructor(private fb: FormBuilder,
    private cdRef: ChangeDetectorRef,
    private mapService: MapService,
    private menuService: MenuEventService,
    private translateService: TranslateService,
    private messageService: MessageEventService) {
    this.landUseValues = EnumUtils.toMap(LandUseType);
    this.menuService.onMainMenuChange().subscribe(() => this.disableDrawForMeasure());
    this.mapService.onRemoveCells().subscribe((geom) => this.removeGeoms(geom));
  }

  public static constructForm(fb: FormBuilder): FormGroup {
    return fb.group({
      measures: fb.array([])
    });
  }

  public ngOnChanges(): void {
    this.mapService.clearMap();
    const resetObject = {
      measures: this.fb.array([])
    };
    this.measureForm.reset(resetObject);
    this.setMeasures(this.measureModels);
    this.cdRef.detectChanges();
    if (this.measures.value.length === 0) {
      this.manageDrawing();
    }
  }

  public get measures(): FormArray {
    if (this.measureForm) {
      return this.measureForm.get('measures') as FormArray;
    }
  }

  public getColor(): string {
    const styles = this.styles.filter((style => !this.geomPerMeasure.map(geom => geom.styleName).includes(style)));
    return styles[0];
  }

  public getAddMeasureColor(): string {
    const styleName = this.getColor();
    return this.getColorFromStyle(styleName);
  }

  public getColorForMeasure(measure): string {
    return this.getColorFromStyle(measure.value.geom.styleName);
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
      if (this.isOpen) {
        this.disableDrawForMeasure();
      }
      this.isOpen = true;
      this.openMeasure = event;
      this.enableDrawForMeasure();
    }
  }

  public onDeleteClick(index: number) {
    this.measures.removeAt(index);
    this.measureModels.splice(index, 1);
    this.mapService.removeMeasure(this.geomPerMeasure[index].id);
    this.geomPerMeasure.splice(index, 1);
    this.measureForm.markAsDirty();
    this.openMeasure = -1;
    this.disableDrawForMeasure();
    if (this.measures.length === 0) {
      this.enableDrawForMeasure();
    }
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
    if (!this.validateGeom()) {
      this.messageService.sendMessage('MEASURES_WITHOUT_CELLS');
    } else {
      if (this.validateVegetation() && this.measureForm.valid) {
        this.openMeasure = -1;
        const measures: MeasureModel[] = [];
        for (const index in this.measures.controls) {
          if (this.measures.controls[index] instanceof FormGroup) {
            const measureFormGroup = this.measures.controls[index] as FormGroup;
            const measureModel = this.fromFormGroupToModel(measureFormGroup);
            measureModel.geom.cells = this.geomPerMeasure[index].cells;
            measures.push(measureModel);
          }
        }
        this.validated = false;
        this.disableDrawForMeasure();
        this.openMeasure = -1;
        return measures;
      }
    }
  }

  public cancelMeasure() {
    this.ngOnChanges();
  }

  private getColorFromStyle(styleName: string): string {
    return MeasureStyles.measureStyles.get(styleName).getFill().getColor().toString();
  }

  private validateVegetation(): boolean {
    for (const index in this.measures.controls) {
      if (this.measures.controls[index] instanceof FormGroup) {
        const measureFormGroup = this.measures.controls[index] as FormGroup;
        const vegFG = measureFormGroup.get('vegetation') as FormGroup;
        const value = vegFG.get('low').value + vegFG.get('middle').value + vegFG.get('high').value;
        if (value > 100 || value < 0) {
          this.messageService.sendMessage('VEGETATION_VALUES_INVALID');
          return false;
        }
      }
    }
    return true;
  }

  private manageDrawing() {
    this.disableDrawForMeasure();
    this.enableDrawForMeasure();
  }

  private enableDrawForMeasure() {
    let measureGeom: FeatureModel;
    if (this.measures.length === 0) {
      measureGeom = new FeatureModel();
      measureGeom.styleName = this.getColor();
      measureGeom.id = this.measures.length;
    } else {
      measureGeom = this.geomPerMeasure[this.openMeasure];
    }
    this.mapService.startDrawing(measureGeom);
    this.featureSubsciption = this.mapService.onFeatureDrawn().subscribe(() => this.addFeatures(measureGeom));
  }

  private disableDrawForMeasure() {
    this.mapService.stopDrawing();
    if (this.featureSubsciption) {
      this.featureSubsciption.unsubscribe();
    }
  }

  private setMeasures(measures: MeasureModel[]) {
    if (measures) {
      this.geomPerMeasure = [];
      const measureFormArray = this.fb.array(measures.map((measure) => this.fromModelToFormGroup(measure)));
      this.measureForm.setControl('measures', measureFormArray);
      measures.forEach((measure) => this.mapService.showFeatures(measure.geom));
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
      geom: {
        id: measureFormModel.geom.id,
        styleName: measureFormModel.geom.styleName,
        cells: []
      }
    };

    return measureModel;
  }

  private fromModelToFormGroup(measure: MeasureModel): FormGroup {
    this.geomPerMeasure.push(measure.geom);
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
      woz: measure.woz,
      geom: this.fb.group({
        id: measure.geom.id,
        styleName: measure.geom.styleName
      })
    });
  }

  private addFeatures(geom: FeatureModel) {
    if (this.openMeasure === -1) {
      this.addNewMeasure(geom);
      this.openMeasure = this.measures.length - 1;
    }
  }

  private addNewMeasure(geom?: FeatureModel) {
    const newModel = new MeasureModel();
    newModel.measureName = this.generateUniqueMeasureName();
    if (geom) {
      newModel.geom = geom;
    } else {
      newModel.geom = new FeatureModel();
      newModel.geom.styleName = this.getColor();
      newModel.geom.id = this.geomPerMeasure.length;
      this.addMeasureColor = this.styles[this.styles.length - 1];
    }
    newModel.measureId = -1;
    this.addMeasure(newModel);
  }

  private addMeasure(measure: MeasureModel) {
    const measureFG = this.fromModelToFormGroup(measure);
    const formArray = this.measureForm.get('measures') as FormArray;
    formArray.push(measureFG);
  }

  private generateUniqueMeasureName(): string {
    const returnValue = this.translateService.instant('AREA');
    let ix = this.measures.length + 1;
    let name = returnValue + ' ' + ix;
    while (!this.isUniqueName(name)) {
      ix = ix + 1;
      name = returnValue + ' ' + ix;
    }
    return name;
  }

  private isUniqueName(name: string): boolean {
    return this.measures.value.findIndex((x) => x.name === name) === -1;
  }

  private removeGeoms(geom: FeatureModel) {
    this.geomPerMeasure[geom.id].cells = this.geomPerMeasure[geom.id].cells.filter(cell => cell.gridId !== geom.cells[0].gridId);
  }

  private validateGeom(): boolean {
    return this.geomPerMeasure.every(geom => {
      return geom.cells.length > 0;
    });
  }
}
