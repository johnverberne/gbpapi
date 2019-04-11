import { Component, ViewChild } from '@angular/core';
import { TranslateService } from '@ngx-translate/core';
import { MessageEventService } from '../../services/message-event-service';
import { ConfirmDialogComponent } from '../../shared/confirm-dialog/confirm-dialog-component';
import { DialogHostDirective } from '../../directives/dialog-host-directive';
import { Router } from '@angular/router';
import { CalculationEventService } from '../../services/calculation-event-serivce';
import { CalculationDialogComponent } from '../../shared/confirm-dialog/calculation-dialog-component';

@Component({
  selector: 'gbp-home',
  templateUrl: './home-component.html',
  styleUrls: ['./home-component.scss']
})
export class HomeComponent {

  @ViewChild(DialogHostDirective) public gbpDialogHost: DialogHostDirective;
  private calculationDialog: CalculationDialogComponent;

  constructor(
    private router: Router,
    private translateService: TranslateService,
    private messageService: MessageEventService,
    private calculationEventService: CalculationEventService) {
      this.messageService.onMessageSend().subscribe((messages: string | string[]) => {
        const dialog: ConfirmDialogComponent = this.gbpDialogHost.createDialog(ConfirmDialogComponent);
        if (typeof messages === 'string') {
          dialog.message = this.translateService.instant(messages);
        } else {
          dialog.message = messages.map((message) => this.translateService.instant(message)).join('; ');
        }
      });
      this.calculationEventService.onCalculationStarted().subscribe(() => {
        this.calculationDialog = this.gbpDialogHost.createDialog(CalculationDialogComponent);
      });
      this.calculationEventService.onCalculationFinished().subscribe(() => {
        this.calculationDialog.closeDialog();
      });
  }
}
