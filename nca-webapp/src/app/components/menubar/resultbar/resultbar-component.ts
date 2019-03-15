import { Component } from '@angular/core';
import { MenuEventService } from '../../../services/menu-event-service';
import { MessageEventService } from '../../../services/message-event-service';
import { Router } from '@angular/router';

@Component({
  selector: 'gbp-resultbar',
  templateUrl: './resultbar-component.html',
  styleUrls: ['./resultbar-component.scss']
})
export class ResultBarComponent {

  public isOpen: boolean = true;
  public activeMenu: string = 'MAP';

  constructor(private menuEventService: MenuEventService,
    private messageService: MessageEventService,
    private router: Router) {

  }

  public onCollapseClick() {
    this.isOpen = !this.isOpen;
    this.menuEventService.menuCollapse(this.isOpen);
  }

  public onMenuClick(event: string) {
    if (this.activeMenu !== event) {
      this.activeMenu = event;
      if (event === 'GRAPH') {
        this.messageService.sendMessage('WIP');
        this.router.navigate(['dummy']);
      } else {
        this.router.navigate([{ outlets: { main: [event.toLowerCase()]}}]);
      }
    }
  }
}
