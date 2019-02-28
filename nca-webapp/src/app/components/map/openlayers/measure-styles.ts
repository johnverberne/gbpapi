import { Style } from 'ol/style';
import { RegularShape } from 'ol/style';
import { Fill } from 'ol/style';

export class MeasureStyles {

  public static measureStyles = new Map<string, Style>([
    ['STYLE_1', new Style({
      image: new RegularShape({
        fill: new Fill({ color: '#D63327' }),
        points: 4,
        radius: 10,
        angle: Math.PI / 4
      })
    })],
    ['STYLE_2', new Style({
      image: new RegularShape({
        fill: new Fill({ color: '#93278F' }),
        points: 4,
        radius: 10,
        angle: Math.PI / 4
      })
    })],
    ['STYLE_3', new Style({
      image: new RegularShape({
        fill: new Fill({ color: '#1C0078' }),
        points: 4,
        radius: 10,
        angle: Math.PI / 4
      })
    })],
    ['STYLE_4', new Style({
      image: new RegularShape({
        fill: new Fill({ color: '#FF931E' }),
        points: 4,
        radius: 10,
        angle: Math.PI / 4
      })
    })]
  ]);
}
