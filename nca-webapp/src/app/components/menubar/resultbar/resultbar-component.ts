import { Component } from '@angular/core';
import { MenuEventService } from '../../../services/menu-event-service';

@Component({
  selector: 'gbp-resultbar',
  templateUrl: './resultbar-component.html',
  styleUrls: ['./resultbar-component.scss']
})
export class ResultBarComponent {

  public isOpen: boolean = true;

  constructor(private menuEventService: MenuEventService) {

  }

  public onCollapseClick() {
    this.isOpen = !this.isOpen;
    this.menuEventService.menuCollapse(this.isOpen);
  }
}
