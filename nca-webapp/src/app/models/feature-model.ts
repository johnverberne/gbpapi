import { Point } from 'ol/src/geom';

export class FeatureModel {
  public id: number;
  public color: string;
  public cells: Point[] = [];
}
