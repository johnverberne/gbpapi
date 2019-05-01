import { Component } from '@angular/core';
import { CurrentProjectService } from 'src/app/services/current-project-service';
import { MessageEventService } from '../../services/message-event-service';
import { ReferenceType } from '../../models/enums/reference-type';

@Component({
  selector: 'gbp-reference',
  templateUrl: './reference-component.html',
  styleUrls: ['./menubar-component.scss', './reference-component.scss']
})

export class ReferenceComponent {

  constructor(public projectService: CurrentProjectService, private messageService: MessageEventService) {

  }

  public onScenarioReferenceClick() {
    this.messageService.sendMessage('WIP');
  }

  public onDefaultReferenceClick() {
    this.projectService.currentProject.reference = ReferenceType.DEFAULT;
  }
}
