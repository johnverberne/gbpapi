<?xml version="1.0" encoding="UTF-8"?>
<sld:StyledLayerDescriptor xmlns:sld="http://www.opengis.net/sld" xmlns:java="java" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:wfs="http://www.opengis.net/wfs" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:gml="http://www.opengis.net/gml" xmlns:ogc="http://www.opengis.net/ogc" xmlns="http://www.opengis.net/sld" version="1.0.0" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <sld:NamedLayer>
    <sld:Name>monitor:receptor_deposition_breakdowns</sld:Name>
    <sld:UserStyle>
      <sld:Name>monitor:receptor_deposition_breakdowns</sld:Name>
      <sld:Title>monitor:receptor_deposition_breakdowns</sld:Title>
      <sld:IsDefault>1</sld:IsDefault>
      <sld:FeatureTypeStyle>
        <sld:Rule>
          <sld:Name>1_50</sld:Name>
          <sld:Title>zoom_level = 1 &amp;&amp; total &gt;= 0 &amp;&amp; total &lt;= 50</sld:Title>
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
                <ogc:Literal>50</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>30000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#F6EFF7</sld:CssParameter>
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
          <sld:Name>1_51</sld:Name>
          <sld:Title>zoom_level = 1 &amp;&amp; total &gt; 50 &amp;&amp; total &lt;= 100</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>50</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>100</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>30000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#D0D1E6</sld:CssParameter>
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
          <sld:Name>1_52</sld:Name>
          <sld:Title>zoom_level = 1 &amp;&amp; total &gt; 100 &amp;&amp; total &lt;= 200</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>100</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>200</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>30000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#A6BDDB</sld:CssParameter>
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
          <sld:Name>1_53</sld:Name>
          <sld:Title>zoom_level = 1 &amp;&amp; total &gt; 200 &amp;&amp; total &lt;= 300</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>200</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>300</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>30000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#67A9CF</sld:CssParameter>
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
          <sld:Name>1_54</sld:Name>
          <sld:Title>zoom_level = 1 &amp;&amp; total &gt; 300 &amp;&amp; total &lt;= 400</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>300</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>400</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>30000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#3690C0</sld:CssParameter>
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
          <sld:Name>1_55</sld:Name>
          <sld:Title>zoom_level = 1 &amp;&amp; total &gt; 400 &amp;&amp; total &lt;= 500</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>400</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>500</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>30000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#02818A</sld:CssParameter>
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
          <sld:Name>1_56</sld:Name>
          <sld:Title>zoom_level = 1 &amp;&amp; total &gt; 500</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>1</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>500</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>0</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>30000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#016450</sld:CssParameter>
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
          <sld:Name>2_50</sld:Name>
          <sld:Title>zoom_level = 2 &amp;&amp; total &gt;= 0 &amp;&amp; total &lt;= 50</sld:Title>
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
                <ogc:Literal>50</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>30000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>60000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#F6EFF7</sld:CssParameter>
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
          <sld:Name>2_51</sld:Name>
          <sld:Title>zoom_level = 2 &amp;&amp; total &gt; 50 &amp;&amp; total &lt;= 100</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>50</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>100</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>30000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>60000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#D0D1E6</sld:CssParameter>
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
          <sld:Name>2_52</sld:Name>
          <sld:Title>zoom_level = 2 &amp;&amp; total &gt; 100 &amp;&amp; total &lt;= 200</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>100</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>200</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>30000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>60000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#A6BDDB</sld:CssParameter>
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
          <sld:Name>2_53</sld:Name>
          <sld:Title>zoom_level = 2 &amp;&amp; total &gt; 200 &amp;&amp; total &lt;= 300</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>200</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>300</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>30000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>60000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#67A9CF</sld:CssParameter>
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
          <sld:Name>2_54</sld:Name>
          <sld:Title>zoom_level = 2 &amp;&amp; total &gt; 300 &amp;&amp; total &lt;= 400</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>300</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>400</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>30000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>60000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#3690C0</sld:CssParameter>
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
          <sld:Name>2_55</sld:Name>
          <sld:Title>zoom_level = 2 &amp;&amp; total &gt; 400 &amp;&amp; total &lt;= 500</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>400</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>500</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>30000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>60000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#02818A</sld:CssParameter>
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
          <sld:Name>2_56</sld:Name>
          <sld:Title>zoom_level = 2 &amp;&amp; total &gt; 500</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>2</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>500</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>30000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>60000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#016450</sld:CssParameter>
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
          <sld:Name>3_50</sld:Name>
          <sld:Title>zoom_level = 3 &amp;&amp; total &gt;= 0 &amp;&amp; total &lt;= 50</sld:Title>
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
                <ogc:Literal>50</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>60000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>150000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#F6EFF7</sld:CssParameter>
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
          <sld:Name>3_51</sld:Name>
          <sld:Title>zoom_level = 3 &amp;&amp; total &gt; 50 &amp;&amp; total &lt;= 100</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>50</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>100</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>60000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>150000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#D0D1E6</sld:CssParameter>
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
          <sld:Name>3_52</sld:Name>
          <sld:Title>zoom_level = 3 &amp;&amp; total &gt; 100 &amp;&amp; total &lt;= 200</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>100</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>200</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>60000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>150000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#A6BDDB</sld:CssParameter>
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
          <sld:Name>3_53</sld:Name>
          <sld:Title>zoom_level = 3 &amp;&amp; total &gt; 200 &amp;&amp; total &lt;= 300</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>200</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>300</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>60000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>150000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#67A9CF</sld:CssParameter>
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
          <sld:Name>3_54</sld:Name>
          <sld:Title>zoom_level = 3 &amp;&amp; total &gt; 300 &amp;&amp; total &lt;= 400</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>300</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>400</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>60000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>150000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#3690C0</sld:CssParameter>
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
          <sld:Name>3_55</sld:Name>
          <sld:Title>zoom_level = 3 &amp;&amp; total &gt; 400 &amp;&amp; total &lt;= 500</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>400</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>500</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>60000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>150000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#02818A</sld:CssParameter>
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
          <sld:Name>3_56</sld:Name>
          <sld:Title>zoom_level = 3 &amp;&amp; total &gt; 500</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>3</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>500</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>60000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>150000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#016450</sld:CssParameter>
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
          <sld:Name>4_50</sld:Name>
          <sld:Title>zoom_level = 4 &amp;&amp; total &gt;= 0 &amp;&amp; total &lt;= 50</sld:Title>
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
                <ogc:Literal>50</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>150000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>300000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#F6EFF7</sld:CssParameter>
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
          <sld:Name>4_51</sld:Name>
          <sld:Title>zoom_level = 4 &amp;&amp; total &gt; 50 &amp;&amp; total &lt;= 100</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>4</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>50</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>100</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>150000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>300000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#D0D1E6</sld:CssParameter>
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
          <sld:Name>4_52</sld:Name>
          <sld:Title>zoom_level = 4 &amp;&amp; total &gt; 100 &amp;&amp; total &lt;= 200</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>4</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>100</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>200</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>150000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>300000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#A6BDDB</sld:CssParameter>
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
          <sld:Name>4_53</sld:Name>
          <sld:Title>zoom_level = 4 &amp;&amp; total &gt; 200 &amp;&amp; total &lt;= 300</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>4</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>200</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>300</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>150000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>300000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#67A9CF</sld:CssParameter>
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
          <sld:Name>4_54</sld:Name>
          <sld:Title>zoom_level = 4 &amp;&amp; total &gt; 300 &amp;&amp; total &lt;= 400</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>4</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>300</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>400</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>150000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>300000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#3690C0</sld:CssParameter>
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
          <sld:Name>4_55</sld:Name>
          <sld:Title>zoom_level = 4 &amp;&amp; total &gt; 400 &amp;&amp; total &lt;= 500</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>4</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>400</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>500</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>150000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>300000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#02818A</sld:CssParameter>
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
          <sld:Name>4_56</sld:Name>
          <sld:Title>zoom_level = 4 &amp;&amp; total &gt; 500</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>4</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>500</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>150000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>300000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#016450</sld:CssParameter>
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
          <sld:Name>5_50</sld:Name>
          <sld:Title>zoom_level = 5 &amp;&amp; total &gt;= 0 &amp;&amp; total &lt;= 50</sld:Title>
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
                <ogc:Literal>50</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>300000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>800000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#F6EFF7</sld:CssParameter>
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
          <sld:Name>5_51</sld:Name>
          <sld:Title>zoom_level = 5 &amp;&amp; total &gt; 50 &amp;&amp; total &lt;= 100</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>5</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>50</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>100</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>300000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>800000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#D0D1E6</sld:CssParameter>
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
          <sld:Name>5_52</sld:Name>
          <sld:Title>zoom_level = 5 &amp;&amp; total &gt; 100 &amp;&amp; total &lt;= 200</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>5</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>100</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>200</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>300000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>800000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#A6BDDB</sld:CssParameter>
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
          <sld:Name>5_53</sld:Name>
          <sld:Title>zoom_level = 5 &amp;&amp; total &gt; 200 &amp;&amp; total &lt;= 300</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>5</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>200</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>300</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>300000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>800000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#67A9CF</sld:CssParameter>
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
          <sld:Name>5_54</sld:Name>
          <sld:Title>zoom_level = 5 &amp;&amp; total &gt; 300 &amp;&amp; total &lt;= 400</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>5</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>300</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>400</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>300000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>800000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#3690C0</sld:CssParameter>
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
          <sld:Name>5_55</sld:Name>
          <sld:Title>zoom_level = 5 &amp;&amp; total &gt; 400 &amp;&amp; total &lt;= 500</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>5</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>400</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
              <ogc:PropertyIsLessThanOrEqualTo>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>500</ogc:Literal>
              </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>300000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>800000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#02818A</sld:CssParameter>
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
          <sld:Name>5_56</sld:Name>
          <sld:Title>zoom_level = 5 &amp;&amp; total &gt; 500</sld:Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoom_level</ogc:PropertyName>
                <ogc:Literal>5</ogc:Literal>
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsGreaterThan>
                <ogc:PropertyName>total</ogc:PropertyName>
                <ogc:Literal>500</ogc:Literal>
              </ogc:PropertyIsGreaterThan>
            </ogc:And>
          </ogc:Filter>
          <sld:MinScaleDenominator>300000</sld:MinScaleDenominator>
          <sld:MaxScaleDenominator>800000</sld:MaxScaleDenominator>
          <sld:PolygonSymbolizer>
            <sld:Fill>
              <sld:CssParameter name="fill">#016450</sld:CssParameter>
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