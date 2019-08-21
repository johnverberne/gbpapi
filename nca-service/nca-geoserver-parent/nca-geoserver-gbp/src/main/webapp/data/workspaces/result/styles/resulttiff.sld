<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:gml="http://www.opengis.net/gml" xmlns:ogc="http://www.opengis.net/ogc" version="1.0.0" xmlns:sld="http://www.opengis.net/sld">
  <UserLayer>
    <sld:LayerFeatureConstraints>
      <sld:FeatureTypeConstraint/>
    </sld:LayerFeatureConstraints>
    <sld:UserStyle>
      <sld:Name></sld:Name>
      <sld:FeatureTypeStyle>
        <sld:Rule>
          <sld:RasterSymbolizer>
            <sld:ChannelSelection>
              <sld:GrayChannel>
                <sld:SourceChannelName>1</sld:SourceChannelName>
              </sld:GrayChannel>
            </sld:ChannelSelection>
		    <sld:ColorMap type="ramp">
		      <sld:ColorMapEntry color="${env('legendrgbmin','0xca0020')}" quantity="${env('legendmin',-10)}" label="min" opacity="${env('opacitymin',1)}"/>
		      <sld:ColorMapEntry color="${env('legendrgbzero','0xb3ff39')}" quantity="0" label="0" opacity="${env('opacityzero',0.4)}"/> 
		      <sld:ColorMapEntry color="${env('legendrgbmax','0x0571b0')}" quantity="${env('legendmax',10)}" label="max" opacity="${env('opacitymax',1)}"/>      
		    </sld:ColorMap>
          </sld:RasterSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </UserLayer>
</StyledLayerDescriptor>
