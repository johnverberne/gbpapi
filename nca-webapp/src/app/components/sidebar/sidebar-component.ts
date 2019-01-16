import { Component } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { MessageEventService } from '../../services/message-event-service';

@Component({
  selector: 'gbp-sidebar',
  templateUrl: './sidebar-component.html',
  styleUrls: ['./sidebar-component.scss']
})
export class SidebarComponent {

  public activeMenu: string = 'REFERENCE';

  constructor(
    private translateService: TranslateService,
    private messageService: MessageEventService) {
  }

  public onReferenceClick() {
    this.activeMenu = 'REFERENCE';
  }

  public onScenarioClick() {
    this.activeMenu = 'SCENARIO';
    this.messageService.sendMessage('WIP');
  }

  public onResultClick() {
    this.activeMenu = 'RESULT';
    this.messageService.sendMessage('WIP');
  }

  public onLayersClick() {
    this.activeMenu = 'LAYERS';
    this.messageService.sendMessage('WIP');
  }

  public onSettingsClick() {
    this.activeMenu = 'SETTINGS';
    this.messageService.sendMessage('WIP');
  }

}
