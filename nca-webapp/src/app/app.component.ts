import { Component } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { Router } from '@angular/router';
import { MenuEventService } from './services/menu-event-service';

@Component({
  selector: 'gbp-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  public title = 'gbp';
  public openMenu: boolean = true;

  constructor(
    private translate: TranslateService,
    private router: Router,
    private menuEventService: MenuEventService
  ) {
    // this language will be used as a fallback when a
    // translation isn't found in the current language
    translate.setDefaultLang('nl');

    // the lang to use, if the lang isn't available, it will use the current loader to get them
    translate.use('nl');
    this.menuEventService.onMenuCollapse().subscribe((collapse) => {
      this.openMenu = collapse;
    });
  }
}
