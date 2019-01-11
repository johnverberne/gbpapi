import { Component, Input, Output, HostListener, EventEmitter } from '@angular/core';

import { TranslateService } from '@ngx-translate/core';

@Component({
  selector: 'gbp-modal',
  templateUrl: 'modal-component.html',
  styleUrls: ['./modal-component.scss']
})
export class ModalComponent {
  @Input() public title: string;
  @Input() public closeButton = true;
  @Input() public footer = true;
  @Input() public spinner = false;

  @Output() public okay = new EventEmitter<void>();
  @Output() public cancel = new EventEmitter<void>();
  @Output() public close = new EventEmitter<any>();

  constructor(private translateService: TranslateService) {
  }

  public okayDialog() {
    this.okay.emit();
    this.closeDialog();
  }

  public cancelDialog() {
    this.cancel.emit();
    this.closeDialog();
  }

  public closeDialog() {
    this.close.emit();
  }

  @HostListener('window:keyup', ['$event'])
  public onMouseEnter(event: KeyboardEvent) {
    this.keyUp(event);
  }

  private keyUp(event: KeyboardEvent) {
    if (event.keyCode === 27) {
      this.cancelDialog();
    }
  }
}
