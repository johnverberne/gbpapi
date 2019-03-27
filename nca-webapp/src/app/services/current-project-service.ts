import { Injectable } from '@angular/core';
import { ProjectModel } from '../models/project-model';

@Injectable()
export class CurrentProjectService {

  public currentProject: ProjectModel = new ProjectModel();

  public hasResults(): boolean {
    return this.currentProject.scenarios.findIndex((scenario) => scenario.results.length > 0) !== -1;
  }

}
