import { Component, ViewChild } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { MessageEventService } from '../../services/message-event-service';
import { ConfirmDialogComponent } from '../../shared/confirm-dialog/confirm-dialog-component';
import { DialogHostDirective } from '../../directives/dialog-host-directive';
import { MenuEventService } from '../../services/menu-event-service';
import { Router } from '@angular/router';

@Component({
  selector: 'gbp-home',
  templateUrl: './home-component.html',
  styleUrls: ['./home-component.scss']
})
export class HomeComponent {

  @ViewChild(DialogHostDirective) public gbpDialogHost: DialogHostDirective;

  public openMenu: boolean = true;

  constructor(
    private router: Router,
    private translateService: TranslateService,
    private messageService: MessageEventService,
    private menuEventService: MenuEventService) {
      this.messageService.onMessageSend().subscribe((messages: string | string[]) => {
        const dialog: ConfirmDialogComponent = this.gbpDialogHost.createDialog(ConfirmDialogComponent);
        if (typeof messages === 'string') {
          dialog.message = this.translateService.instant(messages);
        } else {
          dialog.message = messages.map((message) => this.translateService.instant(message)).join('; ');
        }
      });
      this.menuEventService.onMenuCollapse().subscribe((collapse) => {
        this.openMenu = collapse;
      });
  }
}
