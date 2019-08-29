import { Component } from '@angular/core';
import { MenuEventService } from '../../services/menu-event-service';
import { MessageEventService } from '../../services/message-event-service';
import { Router } from '@angular/router';

@Component({
  selector: 'gbp-resultbar',
  templateUrl: './resultbar-component.html',
  styleUrls: ['./resultbar-component.scss']
})
export class ResultBarComponent {

  public isOpen: boolean = true;

  constructor(private menuEventService: MenuEventService,
    private messageService: MessageEventService,
    private router: Router) {
  }

  public onCollapseClick() {
    this.isOpen = !this.isOpen;
    this.menuEventService.menuCollapse(this.isOpen);
  }

  public onMenuClick(event: string) {
    if (this.currentAuxRoute !== event) {
      this.router.navigate([{ outlets: { main: event.toLowerCase() } }]);
      if (event === 'GRAPH') {
        this.messageService.sendMessage('WIP');
      }
      if (event === 'MAP') {
        this.router.navigate([{ outlets: { primary: 'layers', main: 'map' } }]);
      }
    }
  }

  public get currentAuxRoute() {
    const url = this.router.routerState.snapshot.url;
    const startIndex = url.indexOf(':');
    const endIndex = url.indexOf(')');
    return url.substring(startIndex + 1, endIndex).toLocaleUpperCase();
  }
}
