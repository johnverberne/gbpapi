import { Component } from '@angular/core';
import { MenuEventService } from '../../services/menu-event-service';
import { CurrentProjectService } from '../../services/current-project-service';
import { ResultType } from '../../models/enums/result-type';

@Component({
  selector: 'gbp-result-table',
  templateUrl: './result-table-component.html',
  styleUrls: ['./result-table-component.scss']
})
export class ResultTableComponent {

  private scenarioIndex = 0;
  private resultType: ResultType = ResultType.PHYSICAL;

  constructor(private menuEventService: MenuEventService, public projectService: CurrentProjectService) {
    this.menuEventService.onScenarioChange().subscribe((index) => this.scenarioIndex = index);
  }

  get results() {
    return this.projectService.currentProject.scenarios[this.scenarioIndex].
      results.filter((result) => result.class.toUpperCase() === this.resultType);
  }
}
