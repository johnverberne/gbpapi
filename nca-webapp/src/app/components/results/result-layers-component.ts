import { Component } from '@angular/core';
import { MenuEventService } from '../../services/menu-event-service';
import { CurrentProjectService } from '../../services/current-project-service';

@Component({
  selector: 'gbp-result-layers',
  templateUrl: './result-layers-component.html',
  styleUrls: ['./result-layers-component.scss']
})

export class ResultLayersComponent {
  public onLayerClick(event: string) {
    // update openlayers.components with desired chart 
  }

}
