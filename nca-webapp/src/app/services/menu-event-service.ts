import { Injectable } from '@angular/core';
import { Subject, Observable } from 'rxjs';
import { ResultType } from '../models/enums/result-type';

@Injectable()
export class MenuEventService {

  public isOpen: boolean = true;

  private scenarioChangeSubject: Subject<number> = new Subject();
  private mainMenuChangeSubject: Subject<void> = new Subject();
  private resultTypeChangeSubject: Subject<ResultType> = new Subject();
  private showResultMapSubject: Subject<void> = new Subject();

  public menuCollapse() {
    this.isOpen = !this.isOpen;
  }

  public onScenarioChange(): Observable<number> {
    return this.scenarioChangeSubject.asObservable();
  }

  public scenarioChange(index: number) {
    this.scenarioChangeSubject.next(index);
  }

  public onMainMenuChange(): Observable<void> {
    return this.mainMenuChangeSubject.asObservable();
  }

  public mainMenuChange() {
    this.mainMenuChangeSubject.next();
  }

  public resultTypeChange(type: ResultType) {
    this.resultTypeChangeSubject.next(type);
  }

  public onResultTypeChange(): Observable<ResultType> {
    return this.resultTypeChangeSubject.asObservable();
  }

  public showResultMap() {
    this.showResultMapSubject.next();
  }

  public onShowResultMap(): Observable<void> {
    return this.showResultMapSubject.asObservable();
  }
}
