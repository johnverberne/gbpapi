import { Directive, ComponentFactoryResolver, ViewContainerRef, Type } from '@angular/core';

import { BaseDialogComponent } from '../shared/modal/base-dialog-component';

@Directive({
  selector: '[gbpDialogHost]'
})
export class DialogHostDirective {

  constructor(private viewContainer: ViewContainerRef, private componentFactoryResolver: ComponentFactoryResolver) {
  }

  public createDialog<T extends BaseDialogComponent>(dialogComponentClass: Type<T>): T {
    this.viewContainer.clear();

    const dialogComponentFactory = this.componentFactoryResolver.resolveComponentFactory(dialogComponentClass);
    const dialogComponentRef = this.viewContainer.createComponent(dialogComponentFactory);

    dialogComponentRef.instance.close.subscribe(() => {
      dialogComponentRef.destroy();
    });

    return dialogComponentRef.instance;
  }
}
