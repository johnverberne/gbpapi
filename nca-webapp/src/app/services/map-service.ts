import { Injectable } from '@angular/core';
import { Subject, Observable } from 'rxjs';
import { Point } from 'geojson';
import { GeometryModel } from '../models/geometry-model';

@Injectable()
export class MapService {

  private drawSubject: Subject<GeometryModel> = new Subject();
  private stopDrawSubject: Subject<void> = new Subject();
  private featureDrawnSubject: Subject<void> = new Subject();

  public onStartDrawing(): Observable<GeometryModel> {
    return this.drawSubject.asObservable();
  }

  public startDrawing(geom: GeometryModel) {
    this.drawSubject.next(geom);
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
