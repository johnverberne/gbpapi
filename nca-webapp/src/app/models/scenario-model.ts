import { MeasureModel } from './measure-model';
import { AssessmentResultModel } from './assessment-result-model';

export class ScenarioModel {
  public scenarioId: number;
  public scenarioName: string;
  public measures: MeasureModel[] = [];
  public results: AssessmentResultModel[] = [];
  public key: string;
}
