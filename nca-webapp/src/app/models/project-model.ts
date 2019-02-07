import { ReferenceType } from './enums/reference-type';
import { ScenarioModel } from './scenario-model';

export class ProjectModel {
  public projectId: number;
  public reference: ReferenceType;
  public results: any;
  public scenarios: ScenarioModel[] = [];
}
