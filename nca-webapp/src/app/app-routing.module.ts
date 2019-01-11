import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';
import { OpenlayersComponent } from './components/map/openlayers/openlayers.component';
import { LeafletComponent } from './components/map/leaflet/leaflet.component';

const routes: Routes = [
  {
    path: '',
    canActivate: [],
    children: [
      {
        path: 'leaflet', component: LeafletComponent
      }, {
        path: 'openlayers', component: OpenlayersComponent
      }]
  }

];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, {
      useHash: Boolean(history.pushState) === false,
      preloadingStrategy: PreloadAllModules
    }),
  ],
  exports: [ RouterModule ]
})
export class AppRoutingModule { }
