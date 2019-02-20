import { Injectable } from '@angular/core';
import { Subject, Observable } from 'rxjs';
import { FeatureModel } from '../models/feature-model';

@Injectable()
export class MapService {

  private drawSubject: Subject<FeatureModel> = new Subject();
  private stopDrawSubject: Subject<void> = new Subject();
  private featureDrawnSubject: Subject<void> = new Subject();
  private removeSubject: Subject<number> = new Subject();
  private clearMapSubject: Subject<void> = new Subject();

  public onStartDrawing(): Observable<FeatureModel> {
    return this.drawSubject.asObservable();
  }

  public startDrawing(geom: FeatureModel) {
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

  public removeMeasure(index: number) {
    this.removeSubject.next(index);
  }

  public onRemoveMeasure(): Observable<number> {
    return this.removeSubject.asObservable();
  }

  public clearMap() {
    this.clearMapSubject.next();
  }

  public onClearMap(): Observable<void> {
    return this.clearMapSubject.asObservable();
  }

}
