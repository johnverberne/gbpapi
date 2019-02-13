import { Injectable } from '@angular/core';
import { Subject, Observable } from 'rxjs';
import { Point } from 'geojson';

@Injectable()
export class MapService {

  private drawSubject: Subject<any[]> = new Subject();
  private stopDrawSubject: Subject<void> = new Subject();
  private featureDrawnSubject: Subject<void> = new Subject();

  public onStartDrawing(): Observable<any[]> {
    return this.drawSubject.asObservable();
  }

  public startDrawing(coords: Point[]) {
    this.drawSubject.next(coords);
  }

  public onStopDrawing(): Observable<void> {
    return this.stopDrawSubject.asObservable();
  }

  public stopDrawing() {
    this.stopDrawSubject.next();
  }

  public onFeatureDrawn(): Observable<void> {
    return this.featureDrawnSubject.asObservable();
  }

  public featureDrawn() {
    this.featureDrawnSubject.next();
  }
}
