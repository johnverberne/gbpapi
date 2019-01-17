import { Injectable } from '@angular/core';
import { ProjectModel } from '../models/project-model';

@Injectable()
export class CurrentProjectService {

  public currentProject: ProjectModel = new ProjectModel();

}
