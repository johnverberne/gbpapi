import { Component, Output } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { MessageEventService } from '../../services/message-event-service';
import { Router } from '@angular/router';
import { CurrentProjectService } from '../../services/current-project-service';
import { MenuEventService } from '../../services/menu-event-service';

@Component({
  selector: 'gbp-sidebar',
  templateUrl: './sidebar-component.html',
  styleUrls: ['./sidebar-component.scss']
})
export class SidebarComponent {


  @Output() public activeMenu: string = 'REFERENCE';

  constructor(
    private translateService: TranslateService,
    private messageService: MessageEventService,
    private router: Router,
    public projectService: CurrentProjectService,
    private menuService: MenuEventService) {
  }

  public onMenuClick(event: string) {
    if (this.activeMenu !== event) {
      this.menuService.mainMenuChange();
      this.activeMenu = event;
      if (event === 'LAYERS' || event === 'SETTINGS') {
        this.messageService.sendMessage('WIP');
        this.router.navigate(['dummy']);
      } else {
        this.router.navigate([event.toLowerCase()]);
      }
    }
  }

}
