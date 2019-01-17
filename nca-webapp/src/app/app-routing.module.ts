import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './components/home/home-component';
import { ScenarioComponent } from './components/menubar/scenario-component';
import { ReferenceComponent } from './components/menubar/reference-component';

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
        path: 'scenario', component: ScenarioComponent
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
