import { Component, ViewChild, OnChanges, ChangeDetectorRef, Input } from '@angular/core';
import { CurrentProjectService } from 'src/app/services/current-project-service';
import { ScenarioModel } from 'src/app/models/scenario-model';
import { FormGroup, FormBuilder } from '@angular/forms';
import { MeasureComponent } from './measure-component';
import { TranslateService } from '@ngx-translate/core';
import { ProjectModel } from '../../models/project-model';
import { GridCellModel } from '../../models/grid-cell-model';
import { MessageEventService } from '../../services/message-event-service';

@Component({
  selector: 'gbp-scenario',
  templateUrl: './scenario-component.html',
  styleUrls: ['./menubar-component.scss', './scenario-component.scss']
})
export class ScenarioComponent implements OnChanges {

  @ViewChild(MeasureComponent) private gbpMeasures: MeasureComponent;
  @Input() public scenarioModel: ScenarioModel;
  public scenarioForm: FormGroup;
  private EXTENT_THRESHOLD: number = 1000000;

  constructor(private fb: FormBuilder,
    public cdRef: ChangeDetectorRef,
    public projectService: CurrentProjectService,
    private translateService: TranslateService,
    private messageService: MessageEventService) {
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

  public saveClick() {
    if (this.scenarioForm.valid) {
      this.scenarioModel.scenarioName = this.scenarioForm.get('name').value;
      this.scenarioModel.measures = this.gbpMeasures.saveMeasures();
      if (this.scenarioModel.measures) {
        this.checkMeasureExtent();
      }
    }
    console.log(JSON.stringify(this.projectService.currentProject as ProjectModel));
  }

  public cancelClick() {
    this.gbpMeasures.cancelMeasure();
    this.cancelScenario();
  }

  public hasMeasures() {
    return this.gbpMeasures.measures.length > 0;
  }

  private cancelScenario() {
    this.scenarioForm.patchValue({
      'name': this.scenarioModel.scenarioName
    });
  }

  private checkMeasureExtent() {
    for (const measure of this.scenarioModel.measures) {
      measure.geom.cells.sort(this.compare);
      const start = measure.geom.cells[0].coordsAfrt;
      const end = measure.geom.cells[measure.geom.cells.length - 1].coordsAfrt;
      if (this.getExtentSize(start, end) > this.EXTENT_THRESHOLD) {
        this.messageService.sendMessage('WARNING_LARGE_EXTENT_CALCULATION');
        break;
      }
    }
  }

  private compare(a: GridCellModel, b: GridCellModel) {
    return a.coordsAfrt[1] === b.coordsAfrt[1] ? a.coordsAfrt[0] - b.coordsAfrt[0] : a.coordsAfrt[1] - b.coordsAfrt[1];
  }

  private getExtentSize(start: any, end: any): number {
    const xSize = start[0] - end[0];
    const ySize = start[1] - end[1];
    return Math.abs(xSize) * Math.abs(ySize);
  }

}
