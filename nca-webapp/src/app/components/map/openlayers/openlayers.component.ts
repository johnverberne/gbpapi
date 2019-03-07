import { Component, OnInit } from '@angular/core';
import OlMap from 'ol/Map';
import OlXYZ from 'ol/source/XYZ';
import { Tile as TileLayer, Vector as VectorLayer } from 'ol/layer';
import Draw from 'ol/interaction/Draw';
import OlView from 'ol/View';
import { Vector as VectorSource } from 'ol/source';
import { fromLonLat } from 'ol/proj';
import GeoJSON from 'ol/format/GeoJSON';
import Feature from 'ol/Feature';
import { MapService } from '../../../services/map-service';
import { FeatureModel } from '../../../models/feature-model';
import { Style, Fill, RegularShape } from 'ol/style';
import { Point } from 'ol/src/geom';
import { TileWMS } from 'ol/source';
import { environment } from '../../../../environments/environment';
import { bbox } from 'ol/loadingstrategy';
import { Select } from 'ol/interaction';
import { Stroke } from 'ol/style';
import { DragBox } from 'ol/interaction';
import { platformModifierKeyOnly } from 'ol/events/condition';
import { Collection } from 'ol/src';

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
  private draw: Draw;
  private hexagonLayer: TileLayer;
  private vectorSource: VectorSource;
  private gridSource: VectorSource;
  private gridSource10: VectorSource;
  private bagVector: VectorSource;
  private vector: VectorLayer;
  private gridLayer: VectorLayer;
  private gridLayer10: VectorLayer;
  private bagLayer: VectorLayer;
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
    this.osmLayer = new TileLayer({
      source: new OlXYZ({
        url: 'http://tile.osm.org/{z}/{x}/{y}.png'
      })
    });

    // gbp:wms_hexagons_view
    // gbp:wms_grids10_view
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
          'version=1.0.0&request=GetFeature&typeName=wms_grids10_view&TRANSPARANT=TRUE&' +
          'outputFormat=application/json&srsname=EPSG:3857&' +
          'bbox=' + extent.join(',') + ',EPSG:3857',
      format: new GeoJSON(),
      strategy: bbox,
    });

    this.gridLayer10 = new VectorLayer({
      source: this.gridSource10
    });

    this.bagVector = new VectorSource({
      url: (extent) => `https://geodata.nationaalgeoregister.nl/bag/wfs?service=WFS&LAYERS=BU.Building&` +
          'version=1.1.0&request=GetFeature&typename=bag:pand&STYLES=&TRANSPARANT=TRUE&' +
          'outputFormat=application/json&srsname=EPSG:3857&' +
          //'maxFeatures=50000&' +
          'bbox=' + extent.join(',') + ',EPSG:3857',
      format: new GeoJSON(),
      strategy: bbox,
    });

    this.bagLayer =  new VectorLayer({
      source: this.bagVector
    });

    // gbp:wms_hexagons_view
    // gbp:wms_grids10_view
    this.hexagonLayer = new TileLayer({
      source: new TileWMS({
        url: `${environment.GEOSERVER_ENDPOINT}/wms`,
        params: { 'LAYERS': 'gbp:wms_hexagons_view', 'TILED': true },
        serverType: 'geoserver',
        transition: 0
      })
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

    this.gridSource = new VectorSource({
      url: (extent) => `${environment.GEOSERVER_ENDPOINT}/wfs?service=WFS&` +
          'version=1.0.0&request=GetFeature&typeName=wms_grids_view&transparant=true&' +
          'maxFeatures=1000&outputFormat=application/json&srsname=EPSG:28992&' +
          'bbox=' + extent.join(',') + ',EPSG:28992',
      format: new GeoJSON(),
      strategy: bbox,
    });

    this.gridLayer = new VectorLayer({
      source: this.gridSource
    });

    this.vectorSource = new VectorSource({ wrapX: false });
    this.vector = new VectorLayer({
      source: this.vectorSource
    });

    this.view = new OlView({
      center: fromLonLat([5.183735, 52.118362]), // 52.118362, 5.183735
      zoom: 18
    });

    // this.resultLayer,
    this.map = new OlMap({
      target: 'map',
      layers: [this.osmLayer, this.hexagonLayer,  this.vector, this.gridLayer10, this.bagLayer],
      view: this.view
    });

    this.enableGetGrid();
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

  private enableGetGrid() {
    let selectedFeatures: Feature[];
    const select = new Select({
      layers: [this.gridLayer10]
    });
    this.map.addInteraction(select);
    select.on('select', (e) => {
      selectedFeatures = select.getFeatures().array_;
    });

    const dragBox = new DragBox({
      condition: platformModifierKeyOnly
    });
    this.map.addInteraction(dragBox);
    dragBox.on('boxend', () => {
      const extent = dragBox.getGeometry().getExtent();
      this.gridSource10.forEachFeatureIntersectingExtent(extent, (feature) => {
        selectedFeatures.push(feature);
      });
    });
  }
}
