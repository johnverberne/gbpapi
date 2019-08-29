import { Component } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { Router } from '@angular/router';
import { MenuEventService } from './services/menu-event-service';
import { CurrentProjectService } from './services/current-project-service';

@Component({
  selector: 'gbp-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  public title = 'gbp';

  constructor(
    private translate: TranslateService,
    public router: Router,
    private menuEventService: MenuEventService,
    private projectService: CurrentProjectService
  ) {
    // this language will be used as a fallback when a
    // translation isn't found in the current language
    translate.setDefaultLang('nl');
    // the lang to use, if the lang isn't available, it will use the current loader to get them
    translate.use('nl');
  }

  public isOpen() {
    return this.menuEventService.isOpen;
  }

  public isResultPage() {
    return this.router.url.split('(')[0] === '/result' ||
    (this.router.url.split('(')[0] === '/layers' && this.projectService.hasResults());
  }
}
