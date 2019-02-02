import { Component } from '@angular/core';
import { CurrentProjectService } from 'src/app/services/current-project-service';

@Component({
  selector: 'gbp-result',
  templateUrl: './result-component.html',
  styleUrls: ['./menubar-component.scss', './result-component.scss']
})
export class ResultComponent {

  constructor(public projectService: CurrentProjectService) {
  }

  public get measures() {
    if (this.projectService.currentProject.scenarios[0]) {
      return this.projectService.currentProject.scenarios[0].measures;
    }
  }

  public get scenario() {
    if (this.projectService.currentProject.scenarios) {
      return this.projectService.currentProject.scenarios[0];
    }
  }

}
