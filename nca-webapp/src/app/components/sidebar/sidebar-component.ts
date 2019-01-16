import { Component, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { DialogHostDirective } from '../../directives/dialog-host-directive';
import { ConfirmDialogComponent } from 'src/app/shared/confirm-dialog/confirm-dialog-component';

@Component({
  selector: 'gbp-sidebar',
  templateUrl: './sidebar-component.html',
  styleUrls: ['./sidebar-component.scss']
})
export class SidebarComponent {

  @ViewChild(DialogHostDirective) public dialogHost: DialogHostDirective;

  public activeMenu: string = 'REFERENCE';

  constructor(
    private router: Router,
    private translateService: TranslateService) {
  }

  public onReferenceClick() {
    this.activeMenu = 'REFERENCE';
  }

  public onSettingsClick() {
    this.activeMenu = 'SETTINGS';
    const waitingDialog: ConfirmDialogComponent = this.dialogHost.createDialog(ConfirmDialogComponent);
    waitingDialog.cancelButton = false;
    waitingDialog.okayButton = true;
    waitingDialog.message = this.translateService.instant('WIP');
  }

}
