import { LandUseType } from './enums/landuse-type';
import { VegetationModel } from './vegetation-model';
import { GeometryModel } from './geometry-model';

export class MeasureModel {
  public measureId: number = -1;
  public measureName: string;
  public landuse: LandUseType;
  public vegetation: VegetationModel;
  public inhabitants: number;
  public woz: number;
  public geom: GeometryModel;
}
