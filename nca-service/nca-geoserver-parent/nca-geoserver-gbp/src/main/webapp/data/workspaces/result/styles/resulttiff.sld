<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:gml="http://www.opengis.net/gml" xmlns:ogc="http://www.opengis.net/ogc" version="1.0.0" xmlns:sld="http://www.opengis.net/sld">
  <UserLayer>
    <sld:LayerFeatureConstraints>
      <sld:FeatureTypeConstraint/>
    </sld:LayerFeatureConstraints>
    <sld:UserStyle>
      <sld:Name>TEEB_Afvang_van_PM10_door_groen-actual_change</sld:Name>
      <sld:FeatureTypeStyle>
        <sld:Rule>
          <sld:RasterSymbolizer>
            <sld:ChannelSelection>
              <sld:GrayChannel>
                <sld:SourceChannelName>1</sld:SourceChannelName>
              </sld:GrayChannel>
            </sld:ChannelSelection>
            <sld:ColorMap type="ramp">
              <sld:ColorMapEntry quantity="-4" label="-4" color="#ca0020"/>
              <sld:ColorMapEntry quantity="-3" label="-3" color="#df5251"/>
              <sld:ColorMapEntry quantity="-2" label="-2" color="#f4a582"/>
              <sld:ColorMapEntry quantity="-1" label="-1" color="#d4d25d"/>
              <sld:ColorMapEntry quantity="0" label="0" color="#b3ff39"/>
              <sld:ColorMapEntry quantity="1" label="1" color="#a3e28c"/>
              <sld:ColorMapEntry quantity="2" label="2" color="#92c5de"/>
              <sld:ColorMapEntry quantity="3" label="3" color="#4b9bc7"/>
              <sld:ColorMapEntry quantity="4" label="4" color="#0571b0"/>
            </sld:ColorMap>
          </sld:RasterSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </UserLayer>
</StyledLayerDescriptor>