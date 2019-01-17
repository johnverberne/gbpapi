import { Component, ViewChild, EventEmitter, Input, Output } from '@angular/core';

import { TranslateService } from '@ngx-translate/core';

import { BaseDialogComponent } from '../modal/base-dialog-component';
import { ModalComponent } from '../modal/modal-component';

@Component({
  templateUrl: 'confirm-dialog-component.html',
  selector: 'gbp-confirm-dialog',
  styleUrls: ['./confirm-dialog-component.scss']
})
export class ConfirmDialogComponent extends BaseDialogComponent {

  @Input() public message: string = '';
  public okayButton: boolean = true;
  public cancelButton: boolean = false;

  @ViewChild('dialog') public dialog: ModalComponent;

  constructor(private translateService: TranslateService) {
    super();
  }

  public getDialog(): ModalComponent {
    return this.dialog;
  }
}
