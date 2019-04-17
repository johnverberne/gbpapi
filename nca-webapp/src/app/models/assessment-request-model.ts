import { Coordinate } from 'ol/coordinate';

export class AssessmentRequestModel {
  name: string;
  model: string;
  eco_system_service: string;
  layers: any[] = [];
  extent: Coordinate[] = [];
}
