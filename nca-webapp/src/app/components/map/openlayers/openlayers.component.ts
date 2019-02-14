import { Component, OnInit } from '@angular/core';
import OlMap from 'ol/Map';
import OlXYZ from 'ol/source/XYZ';
import { Tile as TileLayer, Vector as VectorLayer } from 'ol/layer';
import Draw from 'ol/interaction/Draw';
import OlView from 'ol/View';
import { Vector as VectorSource } from 'ol/source';
import { fromLonLat } from 'ol/proj';
import { DrawEvent } from 'ol/events';
import Feature from 'ol/Feature';
import { MapService } from '../../../services/map-service';

@Component({
  selector: 'gbp-openlayers',
  templateUrl: './openlayers.component.html',
  styleUrls: ['./openlayers.component.css']
})
export class OpenlayersComponent implements OnInit {

  map: OlMap;
  source: OlXYZ;
  layer: TileLayer;
  view: OlView;
  draw: Draw;
  vectorSource: VectorSource;
  vector: VectorLayer;

  private coords: any[] = [];

  constructor(private mapService: MapService) {
    this.mapService.onStartDrawing().subscribe((coords) => {
      this.enableDrawPoint(coords);
    });
    this.mapService.onStopDrawing().subscribe(() => {
      this.disableDrawPoint();
    });
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

  private getFeature(coords: any[], event: DrawEvent) {
    const feature = event.feature as Feature;
    coords.push(feature.getGeometry().getCoordinates());
    this.mapService.featureDrawn();
  }

  private disableDrawPoint() {
    this.draw = null;
  }

  private enableDrawPoint(coords: any[]) {
    this.draw = new Draw({
      source: this.vectorSource,
      type: 'Point'
    });
    this.map.addInteraction(this.draw);
    this.draw.on('drawend', (e) => {
      this.getFeature(coords, e);
    });
  }

}
