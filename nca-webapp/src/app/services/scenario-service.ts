import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BaseService } from './base-service';
import { Observable } from 'rxjs';
import { ScenarioModel } from '../models/scenario-model';
import { MeasureModel } from '../models/measure-model';

@Injectable()
export class ScenarioService extends BaseService {
  constructor(http: HttpClient) {
    super(http);
  }

  public saveScenario(scenarioModel: ScenarioModel): Observable<any> {
    return super.post('scenario/save', scenarioModel);
  }

  public saveMeasure(measureModel: MeasureModel): Observable<any> {
    return super.post('measure/save', measureModel);
  }
}
