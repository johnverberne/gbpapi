import { Injectable } from '@angular/core';
import { Subject, Observable } from 'rxjs';

@Injectable()
export class MenuEventService {

  private menuBarCollapseSubject: Subject<boolean> = new Subject();

  public onMenuCollapse(): Observable<boolean> {
    return this.menuBarCollapseSubject.asObservable();
  }

  public menuCollapse(collapse: boolean) {
    this.menuBarCollapseSubject.next(collapse);
  }
}
