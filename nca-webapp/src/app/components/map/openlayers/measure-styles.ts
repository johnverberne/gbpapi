import { Style } from 'ol/style';
import { Fill } from 'ol/style';

export class MeasureStyles {

  public static measureStyles = new Map<string, Style>([
    ['STYLE_1', new Style({
      fill: new Fill({ color: '#D63327' })
    })],
    ['STYLE_2', new Style({
      fill: new Fill({ color: '#93278F' })
    })],
    ['STYLE_3', new Style({
      fill: new Fill({ color: '#1C0078' })
    })],
    ['STYLE_4', new Style({
      fill: new Fill({ color: '#FF931E' })
    })]
  ]);
}
