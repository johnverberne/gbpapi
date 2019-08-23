import { Component } from '@angular/core';
import { MenuEventService } from '../../services/menu-event-service';
import { CurrentProjectService } from '../../services/current-project-service';
import { ResultType } from '../../models/enums/result-type';
import { MapService } from '../../services/map-service';
import { Router } from '@angular/router';

@Component({
  selector: 'gbp-result-table',
  templateUrl: './result-table-component.html',
  styleUrls: ['./result-table-component.scss']
})
export class ResultTableComponent {

  public resultType: ResultType = ResultType.PHYSICAL;
  private scenarioIndex = 0;

  constructor(private menuEventService: MenuEventService, public projectService: CurrentProjectService,
    private mapService: MapService, private router: Router) {
    this.menuEventService.onScenarioChange().subscribe((index) => this.scenarioIndex = index);
  }

  get results() {
    return this.projectService.currentProject.scenarios[this.scenarioIndex].
      results.filter((result) => result.class.toUpperCase() === this.resultType);
  }

  get headers() {
    return this.projectService.currentProject.scenarios.
      filter((scenario) => scenario.results.length > 0).map((scenario) => scenario.scenarioName);
  }

  private scenarioKey() {
    return this.projectService.currentProject.scenarios[this.scenarioIndex].key;
  }

  public scenarioResults(code: number) {
    const validScenarios = this.projectService.currentProject.scenarios.
      filter((scenario) => scenario.results.length > 0);
    const results = [];
    validScenarios.forEach(scenario => {
      scenario.results.forEach((result) => {
        if (result.code === code) {
          results.push(result);
        }
      });
    });
    return results;
  }

  public onResultTypeClick(resultType: string) {
    this.resultType = ResultType[resultType];
  }

  // public onLayerClick(layer: string) {
  //   this.router.navigate([{ outlets: { main: 'map' } }]);
  //   setTimeout(() => {
  //     this.mapService.clearMap();
  //     this.mapService.showResults(true, this.scenarioKey(), layer);
  //   }, 500);
  // }

}
