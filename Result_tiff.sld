<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:gml="http://www.opengis.net/gml" xmlns:ogc="http://www.opengis.net/ogc" version="1.0.0" xmlns:sld="http://www.opengis.net/sld">
  <UserLayer>
    <sld:LayerFeatureConstraints>
      <sld:FeatureTypeConstraint/>
    </sld:LayerFeatureConstraints>
    <sld:UserStyle>
      <sld:Name>gbp</sld:Name>
      <sld:FeatureTypeStyle>
        <sld:Rule>
          <sld:RasterSymbolizer>
            <sld:ColorMap type="ramp">
              <sld:ColorMapEntry quantity="-0.2" label="-0.2" color="#ca0020"/>
              <sld:ColorMapEntry quantity="-0.01" label="-0.1" color="#df5251"/>
              <sld:ColorMapEntry quantity="-0.006" label="-0.06" color="#f4a582"/>
              <sld:ColorMapEntry quantity="-0.003" label="-0.03" color="#d4d25d"/>
              <sld:ColorMapEntry quantity="0" label="0" color="#b3ff39"/>
              <sld:ColorMapEntry quantity="1" label="1" color="#a3e28c"/>
              <sld:ColorMapEntry quantity="5" label="5" color="#92c5de"/>
              <sld:ColorMapEntry quantity="10" label="10" color="#4b9bc7"/>
              <sld:ColorMapEntry quantity="15" label="15" color="#0571b0"/>
            </sld:ColorMap>
          </sld:RasterSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </UserLayer>
</StyledLayerDescriptor>
