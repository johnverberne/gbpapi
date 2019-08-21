import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './components/home/home-component';
import { ScenarioListComponent } from './components/menubar/scenario-list-component';
import { ReferenceComponent } from './components/menubar/reference-component';
import { DummyComponent } from './components/menubar/dummy-component';
import { ScenarioGuard } from './guards/scenario-guard';
import { ResultComponent } from './components/menubar/result-component';
import { ResultGuard } from './guards/result-guard';
import { MapComponent } from './components/map/map-component';
import { ResultTableComponent } from './components/results/result-table-component';
import { ResultLayersComponent } from './components/results/result-layers-component';

const routes: Routes = [
  {
    path: '', redirectTo: '/reference(main:map)', pathMatch: 'full'
  },
  {
    path: '', component: HomeComponent,
    children: [
      {
        path: 'reference', component: ReferenceComponent
      },
      {
        path: 'scenario', component: ScenarioListComponent,
        canActivate: [ScenarioGuard]
      },
      {
        path: 'result', component: ResultComponent,
        canActivate: [ResultGuard],
      },
      {
        path: 'layers', component: ResultLayersComponent,
        //canActivate: [ResultGuard],
      },
      {
        path: 'dummy', component: DummyComponent
      }
    ]
  },
  {
    path: 'map', outlet: 'main' , component: MapComponent
  },
  {
    path: 'table', outlet: 'main', component: ResultTableComponent
  },
  {
    path: 'graph', outlet: 'main', component: DummyComponent
  }
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, {
      useHash: Boolean(history.pushState) === false,
      preloadingStrategy: PreloadAllModules,
      enableTracing: false
    }),
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
