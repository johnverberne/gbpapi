import { Component } from '@angular/core';
import { MapService } from '../../services/map-service';
import { CurrentProjectService } from '../../services/current-project-service';
import { ResultType } from '../../models/enums/result-type';

@Component({
  selector: 'gbp-result-layers',
  templateUrl: './result-layers-component.html',
  styleUrls: ['./menubar-component.scss', './result-layers-component.scss']
})

export class ResultLayersComponent {

  public currentScenarioIndex: number = 0;
  public resultType: ResultType = ResultType.PHYSICAL;

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
  }

  public get resultLayers() {
    return this.scenarios[this.currentScenarioIndex].results.filter((result) => result.class.toUpperCase() === this.resultType);
  }

  public showResult(layer: string, event) {
    this.mapService.showResults(event.currentTarget.checked, this.scenarios[this.currentScenarioIndex].key, layer);
  }

  public onResultTypeClick(resultType: string) {
    this.mapService.clearMap();
    this.resultType = ResultType[resultType];
  }

}
