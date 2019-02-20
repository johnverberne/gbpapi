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
import { Style, Fill, RegularShape } from 'ol/style';
import { Point } from 'ol/src/geom';

@Component({
  selector: 'gbp-openlayers',
  templateUrl: './openlayers.component.html',
  styleUrls: ['./openlayers.component.css']
})
export class OpenlayersComponent implements OnInit {

  public map: OlMap;
  private source: OlXYZ;
  private layer: TileLayer;
  private view: OlView;
  private draw: Draw;
  private vectorSource: VectorSource;
  private vector: VectorLayer;
  private style1: Style;
  private style2: Style;
  private style3: Style;
  private style4: Style;

  constructor(private mapService: MapService) {
    this.mapService.onStartDrawing().subscribe((geom) => {
      this.enableDrawPoint(geom);
    });
    this.mapService.onStopDrawing().subscribe(() => {
      this.disableDrawPoint();
    });
    this.mapService.onRemoveMeasure().subscribe((id) => {
      this.clearFeatures(id);
    });
    this.mapService.onClearMap().subscribe(() => {
      this.clearMap();
    });
  }

  public ngOnInit() {
    this.source = new OlXYZ({
      url: 'http://tile.osm.org/{z}/{x}/{y}.png'
    });

    this.layer = new TileLayer({
      source: this.source
    });

    this.style1 = new Style({
      image: new RegularShape({
        fill: new Fill({ color: '#D63327' }),
        points: 4,
        radius: 10,
        angle: Math.PI / 4
      })
    });

    this.style2 = new Style({
      image: new RegularShape({
        fill: new Fill({ color: '#93278F' }),
        points: 4,
        radius: 10,
        angle: Math.PI / 4
      })
    });

    this.style3 = new Style({
      image: new RegularShape({
        fill: new Fill({ color: '#1C0078' }),
        points: 4,
        radius: 10,
        angle: Math.PI / 4
      })
    });

    this.style4 = new Style({
      image: new RegularShape({
        fill: new Fill({ color: '#FF931E' }),
        points: 4,
        radius: 10,
        angle: Math.PI / 4
      })
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
    feature.setStyle(this.getStyle(geom.color));
    feature.set('measureId', geom.id);
    geom.cells.push((feature.getGeometry() as Point));
    this.mapService.featureDrawn();
  }

  private getStyle(color: string) {
    if (color === '#D63327') {
      return this.style1;
    } else if (color === '#93278F') {
      return this.style2;
    } else if (color === '#1C0078') {
      return this.style3;
    } else if (color === '#FF931E') {
      return this.style4;
    }
  }

  private disableDrawPoint() {
    this.map.removeInteraction(this.draw);
    // this.clearMap();
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

}
