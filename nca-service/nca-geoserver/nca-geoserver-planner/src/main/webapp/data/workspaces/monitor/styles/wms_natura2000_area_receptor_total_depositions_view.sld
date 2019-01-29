<?xml version="1.0" encoding="UTF-8"?>
<sld:StyledLayerDescriptor xmlns:sld="http://www.opengis.net/sld" xmlns:java="java" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:wfs="http://www.opengis.net/wfs" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:gml="http://www.opengis.net/gml" xmlns:ogc="http://www.opengis.net/ogc" xmlns="http://www.opengis.net/sld" version="1.0.0" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <sld:NamedLayer>
    <sld:Name>monitor:wms_natura2000_area_receptor_total_depositions_view</sld:Name>
    <sld:UserStyle>
      <sld:Name>monitor:wms_natura2000_area_receptor_total_depositions_view</sld:Name>
      <sld:Title>monitor:wms_natura2000_area_receptor_total_depositions_view</sld:Title>
      <sld:IsDefault>1</sld:IsDefault>
      <sld:FeatureTypeStyle>
        <sld:Rule>
          <sld:Name>1_1</sld:Name>
          <sld:Title>zoom_level = 1 &amp;&amp; total &gt;= 0 &amp;&amp; total &lt;= 700</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>0</ogc:Literal>
              </ogc:PropertyIsGreaterThanOrEqualTo>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>700</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>30000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FFFFD4</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>1_2</sld:Name>
          <sld:Title>zoom_level = 1 &amp;&amp; total &gt; 700 &amp;&amp; total &lt;= 1000</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>700</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1000</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>30000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FEE391</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>1_3</sld:Name>
          <sld:Title>zoom_level = 1 &amp;&amp; total &gt; 1000 &amp;&amp; total &lt;= 1300</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1000</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1300</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>30000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FEC44F</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>1_4</sld:Name>
          <sld:Title>zoom_level = 1 &amp;&amp; total &gt; 1300 &amp;&amp; total &lt;= 1600</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1300</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1600</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>30000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FE9929</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>1_5</sld:Name>
          <sld:Title>zoom_level = 1 &amp;&amp; total &gt; 1600 &amp;&amp; total &lt;= 1900</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1600</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1900</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>30000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#EC7014</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>1_6</sld:Name>
          <sld:Title>zoom_level = 1 &amp;&amp; total &gt; 1900 &amp;&amp; total &lt;= 2200</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1900</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>2200</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>30000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#CC4C02</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>1_7</sld:Name>
          <sld:Title>zoom_level = 1 &amp;&amp; total &gt; 2200</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>2200</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>30000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#8C2D04</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>2_1</sld:Name>
          <sld:Title>zoom_level = 2 &amp;&amp; total &gt;= 0 &amp;&amp; total &lt;= 700</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>0</ogc:Literal>
              </ogc:PropertyIsGreaterThanOrEqualTo>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>700</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>30000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>60000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FFFFD4</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>2_2</sld:Name>
          <sld:Title>zoom_level = 2 &amp;&amp; total &gt; 700 &amp;&amp; total &lt;= 1000</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>700</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1000</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>30000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>60000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FEE391</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>2_3</sld:Name>
          <sld:Title>zoom_level = 2 &amp;&amp; total &gt; 1000 &amp;&amp; total &lt;= 1300</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1000</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1300</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>30000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>60000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FEC44F</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>2_4</sld:Name>
          <sld:Title>zoom_level = 2 &amp;&amp; total &gt; 1300 &amp;&amp; total &lt;= 1600</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1300</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1600</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>30000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>60000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FE9929</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>2_5</sld:Name>
          <sld:Title>zoom_level = 2 &amp;&amp; total &gt; 1600 &amp;&amp; total &lt;= 1900</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1600</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1900</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>30000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>60000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#EC7014</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>2_6</sld:Name>
          <sld:Title>zoom_level = 2 &amp;&amp; total &gt; 1900 &amp;&amp; total &lt;= 2200</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1900</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>2200</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>30000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>60000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#CC4C02</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>2_7</sld:Name>
          <sld:Title>zoom_level = 2 &amp;&amp; total &gt; 2200</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>2200</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>30000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>60000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#8C2D04</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>3_1</sld:Name>
          <sld:Title>zoom_level = 3 &amp;&amp; total &gt;= 0 &amp;&amp; total &lt;= 700</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>0</ogc:Literal>
              </ogc:PropertyIsGreaterThanOrEqualTo>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>700</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>60000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>150000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FFFFD4</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>3_2</sld:Name>
          <sld:Title>zoom_level = 3 &amp;&amp; total &gt; 700 &amp;&amp; total &lt;= 1000</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>700</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1000</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>60000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>150000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FEE391</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>3_3</sld:Name>
          <sld:Title>zoom_level = 3 &amp;&amp; total &gt; 1000 &amp;&amp; total &lt;= 1300</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1000</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1300</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>60000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>150000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FEC44F</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>3_4</sld:Name>
          <sld:Title>zoom_level = 3 &amp;&amp; total &gt; 1300 &amp;&amp; total &lt;= 1600</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1300</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1600</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>60000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>150000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FE9929</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>3_5</sld:Name>
          <sld:Title>zoom_level = 3 &amp;&amp; total &gt; 1600 &amp;&amp; total &lt;= 1900</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1600</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1900</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>60000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>150000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#EC7014</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>3_6</sld:Name>
          <sld:Title>zoom_level = 3 &amp;&amp; total &gt; 1900 &amp;&amp; total &lt;= 2200</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1900</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>2200</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>60000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>150000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#CC4C02</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>3_7</sld:Name>
          <sld:Title>zoom_level = 3 &amp;&amp; total &gt; 2200</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>2200</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>60000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>150000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#8C2D04</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>4_1</sld:Name>
          <sld:Title>zoom_level = 4 &amp;&amp; total &gt;= 0 &amp;&amp; total &lt;= 700</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>4</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>0</ogc:Literal>
              </ogc:PropertyIsGreaterThanOrEqualTo>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>700</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>150000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>300000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FFFFD4</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>4_2</sld:Name>
          <sld:Title>zoom_level = 4 &amp;&amp; total &gt; 700 &amp;&amp; total &lt;= 1000</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>4</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>700</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1000</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>150000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>300000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FEE391</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>4_3</sld:Name>
          <sld:Title>zoom_level = 4 &amp;&amp; total &gt; 1000 &amp;&amp; total &lt;= 1300</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>4</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1000</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1300</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>150000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>300000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FEC44F</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>4_4</sld:Name>
          <sld:Title>zoom_level = 4 &amp;&amp; total &gt; 1300 &amp;&amp; total &lt;= 1600</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>4</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1300</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1600</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>150000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>300000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FE9929</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>4_5</sld:Name>
          <sld:Title>zoom_level = 4 &amp;&amp; total &gt; 1600 &amp;&amp; total &lt;= 1900</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>4</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1600</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1900</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>150000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>300000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#EC7014</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>4_6</sld:Name>
          <sld:Title>zoom_level = 4 &amp;&amp; total &gt; 1900 &amp;&amp; total &lt;= 2200</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>4</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1900</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>2200</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>150000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>300000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#CC4C02</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>4_7</sld:Name>
          <sld:Title>zoom_level = 4 &amp;&amp; total &gt; 2200</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>4</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>2200</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>150000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>300000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#8C2D04</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>5_1</sld:Name>
          <sld:Title>zoom_level = 5 &amp;&amp; total &gt;= 0 &amp;&amp; total &lt;= 700</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>5</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>0</ogc:Literal>
              </ogc:PropertyIsGreaterThanOrEqualTo>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>700</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>300000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>800000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FFFFD4</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>5_2</sld:Name>
          <sld:Title>zoom_level = 5 &amp;&amp; total &gt; 700 &amp;&amp; total &lt;= 1000</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>5</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>700</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1000</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>300000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>800000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FEE391</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>5_3</sld:Name>
          <sld:Title>zoom_level = 5 &amp;&amp; total &gt; 1000 &amp;&amp; total &lt;= 1300</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>5</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1000</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1300</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>300000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>800000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FEC44F</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>5_4</sld:Name>
          <sld:Title>zoom_level = 5 &amp;&amp; total &gt; 1300 &amp;&amp; total &lt;= 1600</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>5</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1300</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1600</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>300000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>800000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#FE9929</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>5_5</sld:Name>
          <sld:Title>zoom_level = 5 &amp;&amp; total &gt; 1600 &amp;&amp; total &lt;= 1900</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>5</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1600</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1900</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>300000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>800000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#EC7014</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>5_6</sld:Name>
          <sld:Title>zoom_level = 5 &amp;&amp; total &gt; 1900 &amp;&amp; total &lt;= 2200</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>5</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>1900</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>2200</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>300000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>800000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#CC4C02</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
        <sld:Rule>
          <sld:Name>5_7</sld:Name>
          <sld:Title>zoom_level = 5 &amp;&amp; total &gt; 2200</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>5</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>2200</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>300000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>800000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#8C2D04</sld:CssParameter>
              <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
            </sld:Fill>
            <sld:Stroke>
              <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
              <sld:CssParameter name="stroke-opacity">1</sld:CssParameter>
              <sld:CssParameter name="stroke-width">0.5</sld:CssParameter>
            </sld:Stroke>
          </sld:PolygonSymbolizer>
        </sld:Rule>
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:NamedLayer>
</sld:StyledLayerDescriptor>
