import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router } from '@angular/router';
import { Observable, Subscriber } from 'rxjs';
import { CurrentProjectService } from '../services/current-project-service';

@Injectable({
  providedIn: 'root'
})
export class ResultGuard implements CanActivate {

  constructor(private currentProjectService: CurrentProjectService, private router: Router) {

  }

  canActivate(next: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<boolean> | Promise<boolean> | boolean {
    if (this.currentProjectService.currentProject.results) {
      return Observable.create((canActivateObserver: Subscriber<boolean>) => {
        canActivateObserver.next(true);
        canActivateObserver.complete();
      });
    } else {
      this.router.navigate(['scenario']);
      return false;
    }
  }

}
