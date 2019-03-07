import { Coordinate } from 'ol/coordinate';

export class FeatureModel {
  public id: number;
  public styleName: string;
  public cells: Coordinate[] = [];
}
