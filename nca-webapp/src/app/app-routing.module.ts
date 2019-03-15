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

const routes: Routes = [
  {
    path: '', redirectTo: 'home', pathMatch: 'full'
  },
  {
    path: 'home', component: HomeComponent,
    children: [
      {
        path: '', redirectTo: 'reference', pathMatch: 'prefix'
      },
      {
        path: '', component: MapComponent, outlet: 'main'
      },
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
        children: [
          {
            path: 'table', component: DummyComponent, outlet: 'main'
          },
          {
            path: 'graph', component: DummyComponent, outlet: 'main'
          },
        ]
      },
      {
        path: 'dummy', component: DummyComponent
      }
    ]
  }
];

@NgModule({
  imports: [
    RouterModule.forRoot(routes, {
      useHash: Boolean(history.pushState) === false,
      preloadingStrategy: PreloadAllModules,
      enableTracing: true
    }),
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
