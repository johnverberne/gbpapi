import { Component, OnInit } from '@angular/core';
import { tileLayer, latLng, circle, polygon, map, Control } from 'leaflet';

@Component({
  selector: 'gbp-leaflet-map',
  templateUrl: './leaflet.component.html',
  styleUrls: ['./leaflet.component.scss']
})
export class LeafletComponent implements OnInit {

  private options;
  private layersControl;
  private map: L.Map;

  constructor() { }

  ngOnInit() {
    this.options = {
      layers: [
        tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', { maxZoom: 18, attribution: '...' })
      ],
      zoom: 5,
      center: latLng(46.879966, -121.726909)
    };
    this.map = map('map', this.options);
    this.layersControl = {
      baseLayers: {
        'Open Street Map': tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', { maxZoom: 18, attribution: '...' }),
        'Open Cycle Map': tileLayer('http://{s}.tile.opencyclemap.org/{z}/{x}/{y}.png', { maxZoom: 18, attribution: '...' })
      },
      overlays: {
        'Big Circle': circle([46.95, -122], { radius: 5000 }),
        'Big Square': polygon([[46.8, -121.55], [46.9, -121.55], [46.9, -121.7], [46.8, -121.7]])
      }
    };
    // this.map.addControl(this.layersControl as Control.Layers);
  }

}
