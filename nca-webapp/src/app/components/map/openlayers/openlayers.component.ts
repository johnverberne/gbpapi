import { Component, OnInit } from '@angular/core';
import OlMap from 'ol/Map';
import OlXYZ from 'ol/source/XYZ';
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
import { Select } from 'ol/interaction';
import { DragBox } from 'ol/interaction';
import { platformModifierKeyOnly } from 'ol/events/condition';
import { LayerSwitcher } from 'ol-layerswitcher';
import { Coordinate } from 'ol/coordinate';

@Component({
  selector: 'gbp-openlayers',
  templateUrl: './openlayers.component.html',
  styleUrls: ['./openlayers.component.css']
})
export class OpenlayersComponent implements OnInit {
  public map: OlMap;
  private osmLayer: TileLayer;
  private resultLayer: TileLayer;
  private view: OlView;
  private dragBox: DragBox;
  private select: Select;
  private selectedGridSource: VectorSource;
  private gridSource10: VectorSource;
  private bagVector: VectorSource;
  private selectedGridLayer: VectorLayer;
  private gridLayer10: VectorLayer;
  private bagLayer: VectorLayer;

  private projection = new Projection({
    code: 'EPSG:3857'
  });

  constructor(private mapService: MapService) {
    this.mapService.onStartDrawing().subscribe((geom) => this.enableGetGrid(geom));
    this.mapService.onStopDrawing().subscribe(() => this.disableSelectGrid());
    this.mapService.onRemoveMeasure().subscribe((id) => this.clearFeatures(id));
    this.mapService.onClearMap().subscribe(() => this.clearMap());
    this.mapService.onShowFeatures().subscribe((geom) => this.showFeatures(geom));
  }

  public ngOnInit() {
    this.osmLayer = new TileLayer({
      source: new OlXYZ({
        url: 'http://tile.osm.org/{z}/{x}/{y}.png'
      })
    });

    this.resultLayer = new TileLayer({
      source: new TileWMS({
        url: `${environment.GEOSERVER_ENDPOINT}/wms`,
        params: { 'LAYERS': 'gbp:wms_grids10_view', 'TILED': true },
        serverType: 'geoserver',
        transition: 0
      })
    });

    this.gridSource10 = new VectorSource({
      url: (extent) => `${environment.GEOSERVER_ENDPOINT}/ows?service=WFS&` +
        'version=1.0.0&request=GetFeature&typeName=gbp:wms_grids10_view&TRANSPARANT=TRUE&' +
        'outputFormat=application/json&srsname=EPSG:3857&' +
        'bbox=' + extent.join(',') + ',EPSG:3857',
      format: new GeoJSON(),
      strategy: bbox,
    });

    this.gridLayer10 = new VectorLayer({
      source: this.gridSource10,
      maxResolution: 2
    });

    this.bagVector = new VectorSource({
      url: (extent) => `https://geodata.nationaalgeoregister.nl/bag/wfs?service=WFS&LAYERS=BU.Building&` +
        'version=1.1.0&request=GetFeature&typename=bag:pand&STYLES=&TRANSPARANT=TRUE&' +
        'outputFormat=application/json&srsname=EPSG:3857&' +
        'bbox=' + extent.join(',') + ',EPSG:3857',
      format: new GeoJSON(),
      strategy: bbox,
    });

    this.bagLayer = new VectorLayer({
      source: this.bagVector
    });

    this.selectedGridSource = new VectorSource({
      format: new GeoJSON({
        dataProjection: this.projection,
        featureProjection: this.projection
      }),
      strategy: bbox,
    });

    this.selectedGridLayer = new VectorLayer({
      source: this.selectedGridSource
    });

    this.view = new OlView({
      center: fromLonLat([5.183735, 52.118362], this.projection),
      zoom: 18
    });

    this.map = new OlMap({
      target: 'map',
      layers: [this.osmLayer, this.bagLayer, this.gridLayer10, this.selectedGridLayer],
      view: this.view
    });
    // this.map.addControl(new LayerSwitcher());
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
  }

  private showFeatures(geom: FeatureModel) {
    const features: Feature[] = [];
    geom.cells.forEach((cell) => {
      const feature: Feature = new Feature();
      const poly = this.createMapCell(cell);
      feature.setGeometry(poly);
      feature.set('measureId', geom.id);
      feature.setStyle(this.getStyle(geom.styleName));
      features.push(feature);
    });
    this.selectedGridSource.addFeatures(features);
    const extent = this.selectedGridSource.getExtent();
    this.map.getView().fit(extent);
  }

  private createMapCell(cell: number[]): Polygon {
    const coords: Coordinate[] = [];
    coords.push(cell);
    coords.push([cell[0] + 16, cell[1]]);
    coords.push([cell[0] + 16, cell[1] + 16]);
    coords.push([cell[0], cell[1] + 16]);
    coords.push(cell);
    return new Polygon([coords]);
  }

  private enableGetGrid(geom: FeatureModel) {
    this.select = new Select({
      layers: [this.gridLayer10],
      multi: false
    });
    this.map.addInteraction(this.select);
    this.select.on('select', (e) => {
      const feature: Feature = e.selected[0];
      this.addOrRemoveFeature(feature, geom);
    });

    this.dragBox = new DragBox({
      condition: platformModifierKeyOnly
    });
    this.map.addInteraction(this.dragBox);
    this.dragBox.on('boxend', () => {
      const extent = this.dragBox.getGeometry().getExtent();
      const selectedFeatures: Feature[] = [];
      this.gridSource10.forEachFeatureIntersectingExtent(extent, (feature) => {
        selectedFeatures.push(feature);
      });
      selectedFeatures.forEach(feature => this.addOrRemoveFeature(feature, geom));
    });
  }

  private addOrRemoveFeature(feature: Feature, geom: FeatureModel) {
    const selected = this.selectedGridSource.getFeatureById(feature.getProperties()['grid_id']);
    if (selected) {
      if (selected.get('measureId') === geom.id) {
        this.removeSelectedFeature(selected);
      } else {
        this.removeSelectedFeature(selected);
        this.addSelectedFeature(feature, geom);
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
    geom.cells.push((newFeature.getGeometry() as Polygon).getFirstCoordinate());
    this.selectedGridSource.addFeature(newFeature);
    this.mapService.featureDrawn();
  }

  private removeSelectedFeature(feature: Feature) {
    this.selectedGridSource.removeFeature(feature);
  }

  private disableSelectGrid() {
    this.map.removeInteraction(this.select);
    this.map.removeInteraction(this.dragBox);
  }
}
