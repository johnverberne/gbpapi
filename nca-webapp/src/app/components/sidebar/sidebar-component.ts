import { Component, Output } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { MessageEventService } from '../../services/message-event-service';
import { Router } from '@angular/router';
import { ProjectModel } from '../../models/project-model';
import { CurrentProjectService } from '../../services/current-project-service';

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
    public projectService: CurrentProjectService) {
  }

  public onReferenceClick() {
    this.activeMenu = 'REFERENCE';
    this.router.navigate(['reference']);
  }

  public onScenarioClick() {
    this.activeMenu = 'SCENARIO';
    this.router.navigate(['scenario']);
  }

  public onResultClick() {
    this.activeMenu = 'RESULT';
    this.router.navigate(['result']);
  }

  public onLayersClick() {
    this.activeMenu = 'LAYERS';
    this.messageService.sendMessage('WIP');
    this.router.navigate(['dummy']);
  }

  public onSettingsClick() {
    this.activeMenu = 'SETTINGS';
    this.messageService.sendMessage('WIP');
    this.router.navigate(['dummy']);
  }

}
