import { Output, EventEmitter, OnInit } from '@angular/core';

import { ModalComponent } from './modal-component';

export abstract class BaseDialogComponent implements OnInit {

  @Output() public okay = new EventEmitter<void>();
  @Output() public cancel = new EventEmitter<void>();
  @Output() public close = new EventEmitter<void>();

  public abstract getDialog(): ModalComponent;

  public ngOnInit() {
    this.getDialog().okay.subscribe((value: void) => { this.okay.emit(); });
    this.getDialog().cancel.subscribe((value: void) => { this.cancel.emit(); });
    this.getDialog().close.subscribe((value: void) => { this.close.emit(); });
  }

  public okayDialog() {
    this.getDialog().okayDialog();
  }

  public cancelDialog() {
    this.getDialog().cancelDialog();
  }

  public closeDialog() {
    this.getDialog().closeDialog();
  }
}
