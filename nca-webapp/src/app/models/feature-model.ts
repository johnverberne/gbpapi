import { Point } from 'ol/src/geom';

export class FeatureModel {
  public id: number;
  public styleName: string;
  public cells: Point[] = [];
}
