import { Component, OnInit } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { MessageEventService } from '../../services/message-event-service';
import { Router, NavigationEnd, RouterEvent } from '@angular/router';
import { CurrentProjectService } from '../../services/current-project-service';
import { MenuEventService } from '../../services/menu-event-service';
import { Observable } from 'rxjs';
import { filter } from 'rxjs/operators';

@Component({
  selector: 'gbp-sidebar',
  templateUrl: './sidebar-component.html',
  styleUrls: ['./sidebar-component.scss']
})
export class SidebarComponent implements OnInit {

  public activeMenu: string = 'REFERENCE';
  private navigation: Observable<NavigationEnd>;

  constructor(
    public projectService: CurrentProjectService,
    private translateService: TranslateService,
    private messageService: MessageEventService,
    private router: Router,
    private menuService: MenuEventService) {
      this.navigation = router.events.pipe(
        filter(evt => evt instanceof NavigationEnd)
      ) as Observable<NavigationEnd>;
  }

  public ngOnInit() {
    this.navigation.subscribe(evt => this.navigated(evt));
  }

  public onMenuClick(event: string) {
    if (this.activeMenu !== event) {
      this.menuService.mainMenuChange();
      if (event === 'LAYERS' || event === 'SETTINGS') {
        this.messageService.sendMessage('WIP');
        this.router.navigate(['dummy']);
      } else {
        this.router.navigate([{ outlets: { primary: event.toLowerCase(), main: 'map' }}]);
      }
    }
  }

  private navigated(event: RouterEvent ) {
    const endIndex = event.url.indexOf('(');
    this.activeMenu = event.url.substring(1, endIndex).toLocaleUpperCase();
  }

}
