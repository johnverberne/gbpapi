import { ReferenceType } from './enums/reference-type';
import { ScenarioModel } from './scenario-model';

export class ProjectModel {
  public projectId: number = 1;
  public reference: ReferenceType;
  public scenarios: ScenarioModel[] = [];
}
