import { Injectable } from '@angular/core';
import { Subject, Observable } from 'rxjs';

@Injectable()
export class MenuEventService {

  private menuBarCollapseSubject: Subject<boolean> = new Subject();
  private scenarioChangeSubject: Subject<number> = new Subject();
  private mainMenuChangeSubject: Subject<void> = new Subject();

  public onMenuCollapse(): Observable<boolean> {
    return this.menuBarCollapseSubject.asObservable();
  }

  public menuCollapse(collapse: boolean) {
    this.menuBarCollapseSubject.next(collapse);
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
}
