import { MeasureModel } from './measure-model';

export class ScenarioModel {
  public scenarioId: number;
  public scenarioName: string;
  public measures: MeasureModel[] = [];
}
