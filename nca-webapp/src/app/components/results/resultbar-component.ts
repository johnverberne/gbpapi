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

  constructor(private menuEventService: MenuEventService,
    private messageService: MessageEventService,
    private router: Router) {
  }

  public isOpen() {
    return this.menuEventService.isOpen;
  }

  public onCollapseClick() {
    this.menuEventService.menuCollapse();
  }

  public onMenuClick(event: string) {
    if (this.currentAuxRoute !== event) {
      if (event === 'GRAPH') {
        this.messageService.sendMessage('WIP');
      }
      if (event === 'MAP') {
        this.router.navigate([{ outlets: { primary: 'layers', main: 'map' } }]);
      }
      if (event === 'TABLE') {
        this.router.navigate([{ outlets: { primary: 'result', main: 'table' } }]);
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
