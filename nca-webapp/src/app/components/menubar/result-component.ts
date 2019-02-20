import { Component } from '@angular/core';
import { CurrentProjectService } from 'src/app/services/current-project-service';
import { Router } from '@angular/router';
import { MenuEventService } from '../../services/menu-event-service';
import { MeasureModel } from '../../models/measure-model';
import { MessageEventService } from '../../services/message-event-service';

@Component({
  selector: 'gbp-result',
  templateUrl: './result-component.html',
  styleUrls: ['./menubar-component.scss', './result-component.scss']
})
export class ResultComponent {

  openMenu: boolean = true;

  constructor(public projectService: CurrentProjectService,
    public router: Router,
    private menuEventService: MenuEventService,
    private messageEventService: MessageEventService) {
    this.menuEventService.onMenuCollapse().subscribe((collapse) => {
      this.openMenu = collapse;
    });
  }

  public get measures() {
    if (this.projectService.currentProject.scenarios[0]) {
      return this.projectService.currentProject.scenarios[0].measures;
    }
  }

  public get scenario() {
    if (this.projectService.currentProject.scenarios) {
      return this.projectService.currentProject.scenarios[0];
    }
  }

  public getMeasureSize(measure: MeasureModel) {
    return measure.geom.cells.length;
  }

  public exportClick() {
    this.messageEventService.sendMessage('WIP');
  }

}
