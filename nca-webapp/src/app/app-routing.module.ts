import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './components/home/home-component';

const routes: Routes = [
  {
    path: '', component: HomeComponent,
    canActivate: []
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
