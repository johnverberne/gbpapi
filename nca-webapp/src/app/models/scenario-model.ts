import { DispositionModel } from './disposition-model';

export class ScenarioModel {
  public scenarioId: number;
  public scenarioName: string;
  public dispositions: DispositionModel[] = [];
}
