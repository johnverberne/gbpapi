import { Component } from '@angular/core';
import { MapService } from '../../services/map-service';
import { CurrentProjectService } from '../../services/current-project-service';
import { ResultType } from '../../models/enums/result-type';
import { LayerResultModel } from '../../models/layer-result-model';
import { AssessmentResultModel } from '../../models/assessment-result-model';

@Component({
  selector: 'gbp-result-layers',
  templateUrl: './result-layers-component.html',
  styleUrls: ['./menubar-component.scss', './result-layers-component.scss']
})

export class ResultLayersComponent {

  public currentScenarioIndex: number = 0;
  public resultType: ResultType = ResultType.PHYSICAL;
  private showMeasure: boolean = false;

  constructor(private mapService: MapService, public projectService: CurrentProjectService) {
  }

  public onLayerClick(layer, event) {
    this.mapService.showLayer(layer, event.currentTarget.checked);
  }

  public get scenarios() {
    if (this.projectService.currentProject.scenarios) {
      return this.projectService.currentProject.scenarios;
    }
  }

  public onScenarioClick(index: number) {
    this.mapService.clearMap();
    this.currentScenarioIndex = index;
    this.drawMeasures();
  }

  public get resultLayers() {
    return this.scenarios[this.currentScenarioIndex].results.filter((result) => result.class.toUpperCase() === this.resultType);
  }

  public showResult(result: AssessmentResultModel, event) {
    const layer = new LayerResultModel();
    layer.key = this.scenarios[this.currentScenarioIndex].key;
    layer.url = this.scenarios[this.currentScenarioIndex].url;
    layer.results = result;
    this.mapService.showResults(event.currentTarget.checked, layer);
  }

  public showMeasures(event) {
    this.showMeasure = event.currentTarget.checked;
    this.drawMeasures();
  }

  private drawMeasures() {
    if (this.showMeasure) {
      this.scenarios[this.currentScenarioIndex].measures.forEach((measure) => this.mapService.showFeatures(measure.geom));
    } else {
      this.scenarios[this.currentScenarioIndex].measures.forEach((measure) => this.mapService.removeCells(measure.geom));
    }
  }

  public onResultTypeClick(resultType: string) {
    this.mapService.clearMap();
    this.resultType = ResultType[resultType];
  }

}
