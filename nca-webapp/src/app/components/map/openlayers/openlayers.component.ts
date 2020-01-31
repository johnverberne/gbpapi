import { Component, AfterViewInit } from '@angular/core';
import OlMap from 'ol/Map';
import { Tile as TileLayer, Vector as VectorLayer } from 'ol/layer';
import OlView from 'ol/View';
import { Vector as VectorSource } from 'ol/source';
import { fromLonLat, Projection } from 'ol/proj';
import GeoJSON from 'ol/format/GeoJSON';
import Feature from 'ol/Feature';
import { MapService } from '../../../services/map-service';
import { FeatureModel } from '../../../models/feature-model';
import { Polygon } from 'ol/geom';
import { MeasureStyles } from './measure-styles';
import { TileWMS } from 'ol/source';
import { environment } from '../../../../environments/environment';
import { bbox } from 'ol/loadingstrategy';
import { Select, DragBox, Draw } from 'ol/interaction';
import { platformModifierKeyOnly, click } from 'ol/events/condition';
import { Coordinate } from 'ol/coordinate';
import { GridCellModel } from '../../../models/grid-cell-model';
import { Style, Stroke, Fill } from 'ol/style';
import proj4 from 'proj4';
import { register as proj4register } from 'ol/proj/proj4';
import { ResultSubject } from '../../../models/result-subject';
import { getTopLeft } from 'ol/extent';
import { WMTS } from 'ol/source';
import WMTSTileGrid from 'ol/tilegrid/WMTS';
import { DrawType } from '../../../models/enums/draw-type';
import { LayerSubject } from '../../../models/layer-subject';

@Component({
  selector: 'gbp-openlayers',
  templateUrl: './openlayers.component.html',
  styleUrls: ['./openlayers.component.scss']
})
export class OpenlayersComponent implements AfterViewInit {
  public map: OlMap;
  private pdokLayer: TileLayer;
  private view: OlView;
  private dragBox: DragBox;
  private select: Select;
  private selectedGridSource: VectorSource;
  private gridSource10: VectorSource;
  private bagVector: VectorSource;
  private selectedGridLayer: VectorLayer;
  public gridLayer10: VectorLayer;
  private bagLayer: VectorLayer;
  private lceuLayer: TileLayer;
  private resultLayer: TileLayer;
  private resultSource: TileWMS;
  private draw: Draw;
  private currentDrawStyle: DrawType;
  private currentGeom: FeatureModel;

  private targetProjection = new Projection({
    code: 'EPSG:28992'
  });

  private gridStyle = new Style({
    stroke: new Stroke({
      color: 'grey',
      width: 0.5
    }),
    fill: new Fill({
      color: 'rgba(255, 255, 255, 0.01)' // required to be able to select tiles (transparent features are not selectable)
    }),
  });

  private readonly GRID_SIZE = 10.0;

  // PDOK data:
  // Geldigheidsgebied van het tiling schema in RD-coordinaten:
  private projectionExtent = [-285401.92, 22598.08, 595401.9199999999, 903401.9199999999];
  // Resoluties (pixels per meter) van de zoomniveaus:
  private resolutions = [3440.640, 1720.320, 860.160, 430.080, 215.040, 107.520, 53.760, 26.880, 13.440, 6.720, 3.360, 1.680,
    0.840, 0.420, 0.210];
  // Er zijn 15 (0 tot 14) zoomniveaus beschikbaar van de WMTS-service voor de BRT-Achtergrondkaart:
  private matrixIds = new Array(15);

  constructor(private mapService: MapService) {
    proj4.defs('EPSG:28992',
      '+proj=sterea +lat_0=52.15616055555555 +lon_0=5.38763888888889 +k=0.9999079 +x_0=155000 +y_0=463000 +ellps=bessel ' +
      '+towgs84=565.2369,50.0087,465.658,1.9725,-1.7004,9.0677,4.0812 +units=m +no_defs');
    proj4register(proj4);

    for (let z = 0; z < 15; ++z) {
      this.matrixIds[z] = 'EPSG:28992:' + z;
    }

    this.mapService.onStartDrawing().subscribe((geom) => this.enableGetGrid(geom));
    this.mapService.onStopDrawing().subscribe(() => this.disableSelectGrid());
    this.mapService.onRemoveMeasure().subscribe((id) => this.clearFeatures(id));
    this.mapService.onClearMap().subscribe(() => this.clearMap());
    this.mapService.onShowFeatures().subscribe((geom) => this.showFeatures(geom));
    this.mapService.onShowResults().subscribe((resultSubject) => this.showResults(resultSubject));
    this.mapService.onShowLayer().subscribe((layerSubject) => this.showLayer(layerSubject));

    this.gridSource10 = new VectorSource({
      url: (extent) => `${environment.GEOSERVER_ENDPOINT}/ows?service=WFS&` +
        'version=1.0.0&request=GetFeature&typeName=gbp:grids_view&TRANSPARANT=TRUE&' +
        'outputFormat=application/json&srsname=EPSG:28992&' +
        'bbox=' + extent.join(',') + ',EPSG:28992',
      format: new GeoJSON(),
      strategy: bbox,
    });

    this.gridLayer10 = new VectorLayer({
      source: this.gridSource10,
      maxResolution: 0.8,
      style: this.gridStyle,
      visible: false
    });

    this.pdokLayer = new TileLayer({
      source: new WMTS({
        attributions: 'Kaartgegevens: &copy; <a href="https://www.kadaster.nl">Kadaster</a>',
        url: 'https://geodata.nationaalgeoregister.nl/tiles/service/wmts?',
        layer: 'brtachtergrondkaart',
        matrixSet: this.targetProjection.getCode(),
        format: 'image/png',
        projection: this.targetProjection,
        tileGrid: new WMTSTileGrid({
          origin: getTopLeft(this.projectionExtent),
          resolutions: this.resolutions,
          matrixIds: this.matrixIds
        }),
        style: 'default',
        wrapX: false
      }),
      opacity: 0.4
    });

    this.bagVector = new VectorSource({
      url: (extent) => `https://geodata.nationaalgeoregister.nl/bag/wfs?service=WFS&LAYERS=BU.Building&` +
        'version=1.1.0&request=GetFeature&typename=bag:pand&STYLES=&TRANSPARANT=TRUE&' +
        'outputFormat=application/json&srsname=EPSG:28992&' +
        'bbox=' + extent.join(',') + ',EPSG:28992',
      format: new GeoJSON(),
      strategy: bbox,
    });

    this.bagLayer = new VectorLayer({
      source: this.bagVector,
      visible: false
    });

    this.lceuLayer = new TileLayer({
      source: new TileWMS({
        url: `${environment.GEOSERVER_ENDPOINT}/wms`,
        params: { 'LAYERS': 'LCEU_ini', 'TILED': true, 'STYLES': 'geotiff' },
        serverType: 'geoserver',
        transition: 0
      }),
      opacity: 0.2
    });

    this.resultSource = new TileWMS({
      url: `${environment.GEOSERVER_ENDPOINT}/result/wms`,
      params: { 'LAYERS': '', 'TILED': false, 'STYLES': 'resulttiff', 'ENV': '' },
      serverType: 'geoserver',
      transition: 0,
    });

    this.resultLayer = new TileLayer({
      source: this.resultSource,
      opacity: 0.5,
      visible: false
    });

    this.selectedGridSource = new VectorSource({
      format: new GeoJSON({
        dataProjection: this.targetProjection.getCode(),
        featureProjection: this.targetProjection.getCode()
      }),
      strategy: bbox,
    });

    this.selectedGridLayer = new VectorLayer({
      source: this.selectedGridSource
    });

    this.currentDrawStyle = DrawType.SINGLE;
  }

  public ngAfterViewInit() {
    this.view = new OlView({
        //5.1075035, 52.0814808 utrecht
      //6.098213, 52.521916 zwolle
      center: fromLonLat([6.098213, 52.521916], this.targetProjection.getCode()),
      zoom: 18,
      minZoom: 7,
      maxZoom: 20,
      projection: this.targetProjection.getCode()
    });

    this.map = new OlMap({
      target: 'map',
      layers: [this.pdokLayer, this.lceuLayer, this.bagLayer, this.resultLayer, this.gridLayer10, this.selectedGridLayer],
      view: this.view
    });
  }

  public onDrawModeChange(mode: DrawType) {
    this.currentDrawStyle = mode;
    this.removeInteractions();
    this.enableDrawMode();
  }

  public drawingAndVisibleGrid() {
    return this.gridLayer10.getVisible() && (this.gridLayer10.getMaxResolution() > this.view.getResolution());
  }

  private getStyle(styleName: string) {
    return MeasureStyles.measureStyles.get(styleName);
  }

  private clearFeatures(id: number) {
    this.selectedGridSource.getFeatures().forEach((feature) => {
      if (feature.get('measureId') === id) {
        this.selectedGridSource.removeFeature(feature);
      }
    });
  }

  private clearMap() {
    this.selectedGridSource.clear();
    this.resultLayer.setVisible(false);
  }

  private showResults(resultSubject: ResultSubject) {
    this.gridLayer10.setVisible(false);
    const props = resultSubject.layer.results;
    this.resultSource.updateParams({
      'LAYERS': resultSubject.layer.key + '_' + resultSubject.layer.results.wmsname,
      'TILED': false,
      'ENV': `legendrgbmin:0x${props.legendrgbmin};legendmin:${props.legendmin};
      legendrgbmax:0x${props.legendrgbmax};legendmax:${props.legendmax}`
    });
    this.resultLayer.setVisible(resultSubject.show);
  }

  private showFeatures(geom: FeatureModel) {
    const features: Feature[] = [];
    if (geom.cells.length > 0) {
      geom.cells.forEach((cell) => {
        const feature: Feature = new Feature();
        const poly = this.createMapCell(cell);
        feature.setGeometry(poly);
        feature.set('measureId', geom.id);
        feature.setStyle(this.getStyle(geom.styleName));
        feature.setId(cell.gridId);
        features.push(feature);
      });
      this.selectedGridSource.addFeatures(features);
    }
  }

  private showLayer(layerSubject: LayerSubject) {
    let layerInstance;
    switch (layerSubject.layer) {
      case 'PDOK':
        layerInstance = this.pdokLayer;
        break;
      case 'LCEU':
        layerInstance = this.lceuLayer;
        break;
      case 'BAG':
        layerInstance = this.bagLayer;
        break;
    }
    layerInstance.setVisible(layerSubject.show);
  }

  private createMapCell(cell: GridCellModel): Polygon {
    const coords: Coordinate[] = [];
    coords.push(cell.coords);
    coords.push([cell.coords[0] + this.GRID_SIZE, cell.coords[1]]);
    coords.push([cell.coords[0] + this.GRID_SIZE, cell.coords[1] + this.GRID_SIZE]);
    coords.push([cell.coords[0], cell.coords[1] + this.GRID_SIZE]);
    coords.push(cell.coords);
    return new Polygon([coords]);
  }

  private enableGetGrid(geom: FeatureModel) {
    this.currentGeom = geom;
    if (!this.gridLayer10.getVisible()) {
      this.gridLayer10.setVisible(true);
    }
    this.enableDrawMode();
  }

  private enableDrawMode() {
    if (this.currentDrawStyle === DrawType.SINGLE) {
      this.addSingleDrawInteraction();
    }
    if (this.currentDrawStyle === DrawType.BOX) {
      this.addBoxDrawInteraction();
    }
    if (this.currentDrawStyle === DrawType.POLYGON) {
      this.addPolygonDrawInteraction();
    }
  }

  private addPolygonDrawInteraction() {
    this.draw = new Draw({
      type: 'Polygon',
      condition: platformModifierKeyOnly
    });
    this.map.addInteraction(this.draw);
    this.draw.on('drawend', (event) => {
      if (this.drawingAndVisibleGrid()) {
        const geometry = event.feature.getGeometry();
        const extent = geometry.getExtent();
        const drawCoords = geometry.getCoordinates()[0];
        const selectedFeatures: Feature[] = [];
        this.gridSource10.forEachFeatureIntersectingExtent(extent, (feature) => {
          if (this.pointInPolygon(feature.getGeometry(), drawCoords)) {
            selectedFeatures.push(feature);
          }
        });
        selectedFeatures.forEach(feature => this.addOrRemoveFeature(feature));
      }
    });
  }

  private addBoxDrawInteraction() {
    this.dragBox = new DragBox({
      condition: platformModifierKeyOnly
    });
    this.map.addInteraction(this.dragBox);
    this.dragBox.on('boxend', () => {
      if (this.drawingAndVisibleGrid()) {
        const extent = this.dragBox.getGeometry().getExtent();
        const selectedFeatures: Feature[] = [];
        this.gridSource10.forEachFeatureIntersectingExtent(extent, (feature) => {
          // Temporary fix to overcome double/triple selected identical cells
          if (selectedFeatures.findIndex(element => feature.getId() === element.getId()) === -1) {
            selectedFeatures.push(feature);
          }
        });
        selectedFeatures.forEach(feature => this.addOrRemoveFeature(feature));
      }
    });
  }

  private addSingleDrawInteraction() {
    this.select = new Select({
      layers: [this.gridLayer10],
      style: this.gridStyle,
      condition: click,
      multi: false
    });
    this.map.addInteraction(this.select);
    this.select.on('select', (e) => {
      if (this.drawingAndVisibleGrid()) {
        const feature: Feature = e.selected[0];
        this.addOrRemoveFeature(feature);
      }
    });
  }

  private pointInPolygon(point: any, vs: any) {
    const x = point.getExtent()[0], y = point.getExtent()[1];
    let inside = false;
    for (let i = 0, j = vs.length - 1; i < vs.length; j = i++) {
      const xi = vs[i][0], yi = vs[i][1];
      const xj = vs[j][0], yj = vs[j][1];
      const intersect = ((yi > y) !== (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
      if (intersect) {
        inside = !inside;
      }
    }
    return inside;
  }

  private addOrRemoveFeature(feature: Feature) {
    const geom = this.currentGeom;
    const selected = this.selectedGridSource.getFeatureById(feature.getProperties()['grid_id']);
    if (selected) {
      if (this.currentDrawStyle === DrawType.POLYGON || this.currentDrawStyle === DrawType.BOX) {
        this.removeSelectedFeature(selected, geom);
        this.addSelectedFeature(feature, geom);
      } else {
        if (selected.get('measureId') === geom.id) {
          this.removeSelectedFeature(selected, geom);
        } else {
          this.removeSelectedFeature(selected, geom);
          this.addSelectedFeature(feature, geom);
        }
      }
    } else {
      this.addSelectedFeature(feature, geom);
    }
  }

  private addSelectedFeature(feature: Feature, geom: FeatureModel) {
    const style = this.getStyle(geom.styleName);
    const newFeature: Feature = new Feature();
    newFeature.setGeometry(feature.getGeometry());
    newFeature.setStyle(style);
    newFeature.set('measureId', geom.id);
    newFeature.setId(feature.getProperties()['grid_id']);
    const cell = new GridCellModel();
    cell.gridId = (newFeature.getId() as number);
    const extent = (newFeature.getGeometry() as Polygon).getExtent();
    cell.coords = [extent[0], extent[1]];
    geom.cells.push(cell);
    this.selectedGridSource.addFeature(newFeature);
    this.mapService.featureDrawn();
  }

  private removeSelectedFeature(feature: Feature, geom: FeatureModel) {
    this.selectedGridSource.removeFeature(feature);
    const measureId = feature.get('measureId');
    if (measureId === geom.id) {
      geom.cells = geom.cells.filter(element => element.gridId !== feature.getId());
    } else {
      const cell = new FeatureModel();
      cell.id = measureId;
      const gridCell = new GridCellModel();
      gridCell.gridId = (feature.getId() as number);
      cell.cells = [gridCell];
      this.mapService.removeCells(cell);
    }
  }

  private disableSelectGrid() {
    this.gridLayer10.setVisible(false);
    this.removeInteractions();
  }

  private removeInteractions() {
    this.map.removeInteraction(this.select);
    this.map.removeInteraction(this.dragBox);
    this.map.removeInteraction(this.draw);
  }
}
