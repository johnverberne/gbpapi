import { GridCellModel } from './grid-cell-model';

export class FeatureModel {
  public id: number;
  public styleName: string;
  public cells: GridCellModel[] = [];
}
