import { LandUseType } from './enums/landuse-type';
import { VegetationModel } from './vegetation-model';
import { FeatureModel } from './feature-model';

export class MeasureModel {
  public measureId: number = -1;
  public measureName: string;
  public landuse: LandUseType;
  public vegetation: VegetationModel = new VegetationModel();
  public inhabitants: number;
  public woz: number;
  public geom: FeatureModel;
}
