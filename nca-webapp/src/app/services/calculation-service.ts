import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BaseService } from './base-service';
import { Observable } from 'rxjs';
import { AssessmentRequest } from '../models/assessment-request-model';

@Injectable()
export class CalculationService extends BaseService {
  constructor(http: HttpClient) {
    super(http);
  }

  public startCalculation(request: AssessmentRequest): Observable<any> {
    return super.post('assessmentRequest', request);
  }
}
