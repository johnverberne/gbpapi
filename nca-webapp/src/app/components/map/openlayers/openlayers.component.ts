import { Component, OnInit } from '@angular/core';
import OlMap from 'ol/Map';
import OlXYZ from 'ol/source/XYZ';
import { Tile as TileLayer, Vector as VectorLayer } from 'ol/layer';
import Draw from 'ol/interaction/Draw';
import OlView from 'ol/View';
import { Vector as VectorSource } from 'ol/source';
import { fromLonLat } from 'ol/proj';
import Feature from 'ol/Feature';
import { MapService } from '../../../services/map-service';
import { FeatureModel } from '../../../models/feature-model';
import { Point } from 'ol/geom';
import { MeasureStyles } from './measure-styles';

@Component({
  selector: 'gbp-openlayers',
  templateUrl: './openlayers.component.html',
  styleUrls: ['./openlayers.component.css']
})
export class OpenlayersComponent implements OnInit {
  // Default projection: EPSG:3857
  public map: OlMap;
  private source: OlXYZ;
  private layer: TileLayer;
  private view: OlView;
  private draw: Draw;
  private vectorSource: VectorSource;
  private vector: VectorLayer;

  constructor(private mapService: MapService) {
    this.mapService.onStartDrawing().subscribe((geom) => this.enableDrawPoint(geom));
    this.mapService.onStopDrawing().subscribe(() => this.disableDrawPoint());
    this.mapService.onRemoveMeasure().subscribe((id) => this.clearFeatures(id));
    this.mapService.onClearMap().subscribe(() => this.clearMap());
    this.mapService.onShowFeatures().subscribe((geom) => this.showFeatures(geom));
  }

  public ngOnInit() {
    this.source = new OlXYZ({
      url: 'http://tile.osm.org/{z}/{x}/{y}.png'
    });

    this.layer = new TileLayer({
      source: this.source
    });

    this.vectorSource = new VectorSource({ wrapX: false });
    this.vector = new VectorLayer({
      source: this.vectorSource
    });

    this.view = new OlView({
      center: fromLonLat([5.1776041, 52.1202117]),
      zoom: 13
    });

    this.map = new OlMap({
      target: 'map',
      layers: [this.layer, this.vector],
      view: this.view
    });
  }

  private getFeature(geom: FeatureModel, event: any) {
    const feature = event.feature as Feature;
    feature.setStyle(this.getStyle(geom.styleName));
    feature.set('measureId', geom.id);
    geom.cells.push((feature.getGeometry() as Point));
    this.mapService.featureDrawn();
  }

  private getStyle(styleName: string) {
    return MeasureStyles.measureStyles.get(styleName);
  }

  private disableDrawPoint() {
    this.map.removeInteraction(this.draw);
  }

  private clearFeatures(id: number) {
    this.vectorSource.getFeatures().forEach((feature) => {
      if (feature.get('measureId') === id) {
        this.vectorSource.removeFeature(feature);
      }
    });
  }

  private clearMap() {
    this.vectorSource.clear();
  }

  private enableDrawPoint(geom: FeatureModel) {
    this.draw = new Draw({
      source: this.vectorSource,
      type: 'Point'
    });
    this.map.addInteraction(this.draw);
    this.draw.on('drawend', (e) => {
      this.getFeature(geom, e);
    });
  }

  private showFeatures(geom: FeatureModel) {
    const features: Feature[] = [];
    geom.cells.forEach((cell) => {
      const coords = cell.getCoordinates();
      const feature: Feature = new Feature();
      feature.setGeometry(new Point(coords));
      feature.set('measureId', geom.id);
      feature.setStyle(this.getStyle(geom.styleName));
      features.push(feature);
    });
    this.vectorSource.addFeatures(features);
    const extent = this.vectorSource.getExtent();
    this.map.getView().fit(extent);
  }

}
