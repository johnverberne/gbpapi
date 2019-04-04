import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BaseService } from './base-service';
import { Observable } from 'rxjs';
import { AssessmentRequestModel } from '../models/assessment-request-model';
import { ScenarioRequestModel } from '../models/scenario-request-model';

@Injectable()
export class CalculationService extends BaseService {
  constructor(http: HttpClient) {
    super(http);
  }

  public startCalculation(request: AssessmentRequestModel): Observable<any> {
    return super.post('assessmentRequest', request);
  }

  public startImmediateCalculation(request: AssessmentRequestModel): Observable<any> {
    return super.post('immediatlyAssessmentRequest?apiKey=0000-0000-0000-0001', request);
  }

  public startImmediateScenarioCalculation(request: ScenarioRequestModel[]): Observable<any> {
    return super.post('scenarioAssessmentRequest?apiKey=0000-0000-0000-0001', request);
  }


  public getResults(id: number): Observable<any> {
    return super.get('assessmentResult/' + id);
  }

  public getModelData(model: string): Observable<any> {
    return super.get('modeldata/' + model);
  }
}
