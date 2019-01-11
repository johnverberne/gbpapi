import { BrowserModule } from '@angular/platform-browser';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { LeafletModule } from '@asymmetrik/ngx-leaflet';

import { AppComponent } from './app.component';
import { OpenlayersComponent } from './components/map/openlayers/openlayers.component';
import { LeafletComponent } from './components/map/leaflet/leaflet.component';
import { HeaderComponent } from './components/header/header-component';
import { TranslateModule, TranslateLoader } from '@ngx-translate/core';
import { TranslateHttpLoader } from '@ngx-translate/http-loader';
import { AppRoutingModule } from './app-routing.module';
import { MapComponent } from './components/map/map-component';
import { ConfirmDialogComponent } from './shared/confirm-dialog/confirm-dialog-component';
import { ModalModule } from './shared/modal/modal-module';
import { DialogHostDirective } from './directives/dialog-host-directive';

export function createTranslateLoader(http: HttpClient) {
  return new TranslateHttpLoader(http, './assets/i18n/', '.json');
}

@NgModule({
  declarations: [
    DialogHostDirective,
    AppComponent,
    OpenlayersComponent,
    LeafletComponent,
    HeaderComponent,
    MapComponent,
    ConfirmDialogComponent
  ],
  imports: [
    BrowserModule,
    LeafletModule.forRoot(),
    TranslateModule.forRoot({
      loader: {
        provide: TranslateLoader,
        useFactory: (createTranslateLoader),
        deps: [HttpClient]
      }
    }),
    HttpClientModule,
    AppRoutingModule,
    ModalModule
  ],
  entryComponents: [
    ConfirmDialogComponent
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
