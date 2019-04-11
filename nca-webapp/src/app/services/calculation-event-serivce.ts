import { Injectable } from '@angular/core';
import { Subject, Observable } from 'rxjs';

@Injectable()
export class CalculationEventService {

  private calculationStartedSubject: Subject<void> = new Subject();
  private calculationFinishedSubject: Subject<void> = new Subject();

  public onCalculationStarted(): Observable<void> {
    return this.calculationStartedSubject.asObservable();
  }

  public calculationStarted() {
    this.calculationStartedSubject.next();
  }

  public onCalculationFinished(): Observable<void> {
    return this.calculationFinishedSubject.asObservable();
  }

  public calculationFinished() {
    this.calculationFinishedSubject.next();
  }
}
