import { Component, ViewChild } from '@angular/core';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { DialogHostDirective } from '../../directives/dialog-host-directive';
import { ConfirmDialogComponent } from 'src/app/shared/confirm-dialog/confirm-dialog-component';

@Component({
  selector: 'gbp-header',
  templateUrl: './header-component.html',
  styleUrls: ['./header-component.scss']
})
export class HeaderComponent {

  @ViewChild(DialogHostDirective) public dialogHost: DialogHostDirective;

  constructor(
    private router: Router,
    private translateService: TranslateService) {
  }

  public onLeafletClick() {
    this.router.navigate(['leaflet']);
  }

  public onOpenLayersClick() {
    this.router.navigate(['openlayers']);
  }

  public onHelpClick() {
    const waitingDialog: ConfirmDialogComponent = this.dialogHost.createDialog(ConfirmDialogComponent);
    waitingDialog.cancelButton = false;
    waitingDialog.okayButton = true;
    waitingDialog.message = this.translateService.instant('WIP');
  }

}
