import { Component, OnInit } from '@angular/core';
import OlMap from 'ol/Map';
import OlXYZ from 'ol/source/XYZ';
import { Tile as TileLayer, Vector as VectorLayer } from 'ol/layer';
import Draw from 'ol/interaction/Draw';
import DrawEvent from 'ol/interaction/Draw';
import OlView from 'ol/View';
import { Vector as VectorSource } from 'ol/source';
import { fromLonLat } from 'ol/proj';
import Feature from 'ol/Feature';
import { MapService } from '../../../services/map-service';
import { GeometryModel } from '../../../models/geometry-model';
import { Style, Fill, RegularShape } from 'ol/style';
import { Stroke } from 'ol/style';
import { Circle } from 'ol/style';

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

  constructor(private mapService: MapService) {
    this.mapService.onStartDrawing().subscribe((geom) => {
      this.enableDrawPoint(geom);
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

  private getFeature(coords: any[], event: any) {
    const feature = event.feature as Feature;
    coords.push(feature.values_.geometry.flatCoordinates);
    this.mapService.featureDrawn();
  }

  private disableDrawPoint() {
    this.draw = null;
    this.clearMap();
  }

  private clearMap() {
    this.vectorSource.clear();
  }

  private enableDrawPoint(geom: GeometryModel) {
    this.draw = new Draw({
      source: this.vectorSource,
      type: 'Point'
    });
    this.map.addInteraction(this.draw);
    this.draw.on('drawstart', (e) => {
      const style = new Style({
        image: new RegularShape({
          fill: new Fill({color: geom.color}),
          points: 4,
          radius: 10,
          angle: Math.PI / 4
        })
      });
      e.feature.setStyle(style);
    });
    this.draw.on('drawend', (e) => {
      this.getFeature(geom.cells, e);
    });
  }

}
