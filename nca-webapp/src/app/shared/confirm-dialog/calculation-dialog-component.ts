import { Component, ViewChild } from '@angular/core';

import { TranslateService } from '@ngx-translate/core';

import { BaseDialogComponent } from '../modal/base-dialog-component';
import { ModalComponent } from '../modal/modal-component';
import { environment } from '../../../environments/environment.prod';

@Component({
  templateUrl: 'calculation-dialog-component.html',
  selector: 'gbp-calculation-dialog',
  styleUrls: ['./calculation-dialog-component.scss']
})
export class CalculationDialogComponent extends BaseDialogComponent {

  public okayButton: boolean = true;
  public cancelButton: boolean = false;

  @ViewChild('dialog') public dialog: ModalComponent;

  constructor(private translateService: TranslateService) {
    super();
  }

  public getDialog(): ModalComponent {
    return this.dialog;
  }

  public newTab() {
    window.open(environment.ENDPOINT + '/reference(main:map)', '_blank');
  }

}
