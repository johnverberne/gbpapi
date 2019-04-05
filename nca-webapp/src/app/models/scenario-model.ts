import { MeasureModel } from './measure-model';
import { AssessmentResultModel } from './assessment-result-model';

export class ScenarioModel {
  public scenarioId: number;
  public scenarioName: string;
  public valid: boolean = false;
  public measures: MeasureModel[] = [];
  public results: AssessmentResultModel[] = [{
    "code": 1003,
    "name": "TEEB_verkoeling_door_groen",
    "model": "air_regulation",
    "min": 0.07163385301828384,
    "max": 11.992888450622559,
    "sum": 10123.625,
    "avg": 3.070981979370117,
    "units": "onbekend",
    "class": "physical",
    "legendrgbmin": "ff0000",
    "legendrgbmax": "00ff00",
    "legendmin": 0,
    "legendmax": 100,
    "geobox": {
      "xmin": 140800,
      "ymin": 458580,
      "ymax": 459500,
      "xmax": 142170
    }
  },
  {
    "code": 1001,
    "name": "TEEB_Afvang_van_PM10_door_groen",
    "model": "air_regulation",
    "min": 0.07163385301828384,
    "max": 11.992888450622559,
    "sum": 38706.65625,
    "avg": 3.070981979370117,
    "units": "pm_10",
    "class": "physical",
    "legendrgbmin": "ff0000",
    "legendrgbmax": "00ff00",
    "legendmin": 0,
    "legendmax": 100,
    "geobox": {
      "xmin": 140800,
      "ymin": 458580,
      "ymax": 459500,
      "xmax": 142170
    }
  },
  {
    "code": 1004,
    "name": "TEEB_Minder_gezondheidskosten_door_ziekteverzuim",
    "model": "air_regulation",
    "min": 3.132479429244995,
    "max": 533.2514038085938,
    "sum": 10485.5,
    "avg": 135.20989990234375,
    "units": "Euro",
    "class": "monetary",
    "legendrgbmin": "ff0000",
    "legendrgbmax": "00ff00",
    "legendmin": 0,
    "legendmax": 100,
    "geobox": {
      "xmin": 140800,
      "ymin": 458580,
      "ymax": 459500,
      "xmax": 142170
    }
  },
  {
    "code": 1002,
    "name": "TEEB_Minder_gezondheidskosten_door_afvang_fijn_stof",
    "model": "air_regulation",
    "min": 3.132479429244995,
    "max": 533.2514038085938,
    "sum": 1704185.5,
    "avg": 135.20989990234375,
    "units": "Euro",
    "class": "monetary",
    "legendrgbmin": "ff0000",
    "legendrgbmax": "00ff00",
    "legendmin": 0,
    "legendmax": 100,
    "geobox": {
      "xmin": 140800,
      "ymin": 458580,
      "ymax": 459500,
      "xmax": 142170
    }
  }];
}
