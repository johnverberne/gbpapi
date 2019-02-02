import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './components/home/home-component';
import { ScenarioComponent } from './components/menubar/scenario-component';
import { ReferenceComponent } from './components/menubar/reference-component';
import { DummyComponent } from './components/menubar/dummy-component';
import { ScenarioGuard } from './guards/scenario-guard';
import { ResultComponent } from './components/menubar/result-component';
import { ResultGuard } from './guards/result-guard';

const routes: Routes = [
  {
    path: '', component: HomeComponent,
    canActivate: [],
    children: [
      {
        path: '',
        redirectTo: 'reference',
        pathMatch: 'full'
      },
      {
        path: 'reference', component: ReferenceComponent
      },
      {
        path: 'scenario', component: ScenarioComponent,
        canActivate: [ScenarioGuard]
      },
      {
        path: 'result', component: ResultComponent,
        canActivate: [ResultGuard]
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
      preloadingStrategy: PreloadAllModules
    }),
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
