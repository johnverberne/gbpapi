import { MeasureModel } from './measure-model';

export class ScenarioModel {
  public scenarioId: number;
  public scenarioName: string;
  public valid: boolean = false;
  public measures: MeasureModel[] = [];
  public results: any = [];
}
