<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" 
		xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd" 
		xmlns="http://www.opengis.net/sld" 
		xmlns:ogc="http://www.opengis.net/ogc" 
		xmlns:xlink="http://www.w3.org/1999/xlink" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
		<!-- a named layer is the basic building block of an sld document -->

	<NamedLayer>
		<Name>Geotiff</Name>
		<UserStyle>
		    <!-- they have names, titles and abstracts -->
		  
			<Title>A boring default style</Title>
			<Abstract>A sample style that just prints out a green line</Abstract>

			<FeatureTypeStyle>
				<Rule>
					<RasterSymbolizer>
                      <Opacity>1.0</Opacity>
                      <ColorMap>
                        <ColorMapEntry color="#000000" quantity="0" label="GRAY_INDEX" />
						<ColorMapEntry color="#D8E4BC" quantity="1" label="GRAY_INDEX" />
						<ColorMapEntry color="#C4D79B" quantity="2" label="GRAY_INDEX" />
						<ColorMapEntry color="#B1A0C7" quantity="3" label="GRAY_INDEX" />
						<ColorMapEntry color="#9BBB59" quantity="4" label="GRAY_INDEX" />
						<ColorMapEntry color="#948A54" quantity="5" label="GRAY_INDEX" />
						<ColorMapEntry color="#A6A6A6" quantity="6" label="GRAY_INDEX" />
						<ColorMapEntry color="#92D050" quantity="21" label="GRAY_INDEX" />
						<ColorMapEntry color="#00B050" quantity="22" label="GRAY_INDEX" />
						<ColorMapEntry color="#4F6228" quantity="23" label="GRAY_INDEX" />
						<ColorMapEntry color="#60497A" quantity="24" label="GRAY_INDEX" />
						<ColorMapEntry color="#FCD5B4" quantity="25" label="GRAY_INDEX" />
						<ColorMapEntry color="#31869B" quantity="26" label="GRAY_INDEX" />
						<ColorMapEntry color="#669900" quantity="28" label="GRAY_INDEX" />
						<ColorMapEntry color="#B2B2B2" quantity="29" label="GRAY_INDEX" />
						<ColorMapEntry color="#00CC66" quantity="31" label="GRAY_INDEX" />
						<ColorMapEntry color="#808080" quantity="41" label="GRAY_INDEX" />
						<ColorMapEntry color="#BFBFBF" quantity="42" label="GRAY_INDEX" />
						<ColorMapEntry color="#E6B8B7" quantity="46" label="GRAY_INDEX" />
						<ColorMapEntry color="#538DD5" quantity="51" label="GRAY_INDEX" />
						<ColorMapEntry color="#963634" quantity="92" label="GRAY_INDEX" />
						<ColorMapEntry color="#000000" quantity="999" label="GRAY_INDEX" opacity="0.0"/>
                      </ColorMap>
                  </RasterSymbolizer>
				</Rule>
		    </FeatureTypeStyle>
		</UserStyle>
	</NamedLayer>
</StyledLayerDescriptor>

