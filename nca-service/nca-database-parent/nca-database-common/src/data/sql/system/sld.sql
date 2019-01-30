-- Insert table WMS_ZOOM_LEVELS
INSERT INTO system.wms_zoom_levels (wms_zoom_level_id,name) VALUES (1,'Webapplicatie - standaard');
INSERT INTO system.wms_zoom_levels (wms_zoom_level_id,name) VALUES (2,'Een level - hoog');
INSERT INTO system.wms_zoom_levels (wms_zoom_level_id,name) VALUES (3,'Een level - midden');
INSERT INTO system.wms_zoom_levels (wms_zoom_level_id,name) VALUES (4,'Een level - laag');
INSERT INTO system.wms_zoom_levels (wms_zoom_level_id,name) VALUES (5,'Een level - alles');
INSERT INTO system.wms_zoom_levels (wms_zoom_level_id,name) VALUES (6,'Vergunningsbijlage');
INSERT INTO system.wms_zoom_levels (wms_zoom_level_id,name) VALUES (7,'Bronnen');

-- Insert table WMS_ZOOM_LEVEL_PROPERTIES
INSERT INTO system.wms_zoom_level_properties (wms_zoom_level_id,min_scale,max_scale,zoom_level) VALUES (1,0,30000,1);
INSERT INTO system.wms_zoom_level_properties (wms_zoom_level_id,min_scale,max_scale,zoom_level) VALUES (1,30000,60000,2);
INSERT INTO system.wms_zoom_level_properties (wms_zoom_level_id,min_scale,max_scale,zoom_level) VALUES (1,60000,150000,3);
INSERT INTO system.wms_zoom_level_properties (wms_zoom_level_id,min_scale,max_scale,zoom_level) VALUES (1,150000,300000,4);
INSERT INTO system.wms_zoom_level_properties (wms_zoom_level_id,min_scale,max_scale,zoom_level) VALUES (1,300000,800000,5);
INSERT INTO system.wms_zoom_level_properties (wms_zoom_level_id,min_scale,max_scale,zoom_level) VALUES (2,0,3000000,null);
INSERT INTO system.wms_zoom_level_properties (wms_zoom_level_id,min_scale,max_scale,zoom_level) VALUES (3,0,730000,null);
INSERT INTO system.wms_zoom_level_properties (wms_zoom_level_id,min_scale,max_scale,zoom_level) VALUES (4,0,365000,null);
INSERT INTO system.wms_zoom_level_properties (wms_zoom_level_id,min_scale,max_scale,zoom_level) VALUES (5,0,1999999999,null);
INSERT INTO system.wms_zoom_level_properties (wms_zoom_level_id,min_scale,max_scale,zoom_level) VALUES (6,0,15000,1);
INSERT INTO system.wms_zoom_level_properties (wms_zoom_level_id,min_scale,max_scale,zoom_level) VALUES (6,15000,30000,2);
INSERT INTO system.wms_zoom_level_properties (wms_zoom_level_id,min_scale,max_scale,zoom_level) VALUES (6,30000,75000,3);
INSERT INTO system.wms_zoom_level_properties (wms_zoom_level_id,min_scale,max_scale,zoom_level) VALUES (6,75000,150000,4);
INSERT INTO system.wms_zoom_level_properties (wms_zoom_level_id,min_scale,max_scale,zoom_level) VALUES (6,150000,400000,5);
INSERT INTO system.wms_zoom_level_properties (wms_zoom_level_id,min_scale,max_scale,zoom_level) VALUES (7,0,185000,null);

-- Insert table SLD, within range 1-999
INSERT INTO system.sld (sld_id, description) VALUES (1,'Totale depositie');
INSERT INTO system.sld (sld_id, description) VALUES (2,'KDW-classificatie voor habitat gebieden');
INSERT INTO system.sld (sld_id, description) VALUES (3,'Natuurgebieden (gelabeled)');
INSERT INTO system.sld (sld_id, description) VALUES (4,'Natuurgebieden');
INSERT INTO system.sld (sld_id, description) VALUES (5,'Natuurgebieden (alleen labels)');
INSERT INTO system.sld (sld_id, description) VALUES (6,'Habitat gebieden');
INSERT INTO system.sld (sld_id, description) VALUES (7,'Habitat gebieden met onderscheid relevantie');
INSERT INTO system.sld (sld_id, description) VALUES (8,'Fill gebaseerd op view');
INSERT INTO system.sld (sld_id, description) VALUES (9,'Fill en stroke gebaseerd op view');
INSERT INTO system.sld (sld_id, description) VALUES (11,'Projectbijdrage');
INSERT INTO system.sld (sld_id, description) VALUES (12,'Verschil projectbijdrage');
INSERT INTO system.sld (sld_id, description) VALUES (13,'Netwerk scheepvaart');
INSERT INTO system.sld (sld_id, description) VALUES (14,'Provinciegrenzen');
INSERT INTO system.sld (sld_id, description) VALUES (15,'Resterende ontwikkelngsruimte');
INSERT INTO system.sld (sld_id, description) VALUES (16,'Percentage resterende ontwikkelngsruimte');
INSERT INTO system.sld (sld_id, description) VALUES (17,'Resterende ontwikkelngsruimte waarde');
INSERT INTO system.sld (sld_id, description) VALUES (18,'Percentage resterende ontwikkelngsruimte waarde');
--REMEMBER: update when new SLDs are added: next sld_id = 19

-- Insert table SLD_RULES
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (1,'deposition >= 0 && deposition <= 700','FFFFD4','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (1,'deposition > 700 && deposition <= 1000','FEE391','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (1,'deposition > 1000 && deposition <= 1300','FEC44F','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (1,'deposition > 1300 && deposition <= 1600','FE9929','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (1,'deposition > 1600 && deposition <= 1900','EC7014','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (1,'deposition > 1900 && deposition <= 2200','CC4C02','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (1,'deposition > 2200','8C2D04','FFFFFF',null,null,null);

INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (2,'critical_deposition_classification = high_sensitivity','7B3294','E4E4E4',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (2,'critical_deposition_classification = normal_sensitivity','C2A5CF','E4E4E4',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (2,'critical_deposition_classification = low_sensitivity','EBF5C8','E4E4E4',null,null,null);

INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (3,'bird_directive = false && habitat_directive = true',null,null,'<sld:PolygonSymbolizer>
  <sld:Fill>
    <sld:CssParameter name="fill">#E6E600</sld:CssParameter>
    <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
  </sld:Fill>
  <sld:Stroke />
</sld:PolygonSymbolizer>
<sld:TextSymbolizer>
  <sld:Label>
    <ogc:PropertyName>name</ogc:PropertyName>
  </sld:Label>
  <sld:Font>
    <sld:CssParameter name="font-family">RijksoverheidSansText-Bold</sld:CssParameter>
    <sld:CssParameter name="font-size">13</sld:CssParameter>
    <sld:CssParameter name="font-style">normal</sld:CssParameter>
    <sld:CssParameter name="font-weight">bold</sld:CssParameter>
  </sld:Font>
  <sld:LabelPlacement>
    <sld:PointPlacement>
      <sld:AnchorPoint>
        <sld:AnchorPointX>0.5</sld:AnchorPointX>
        <sld:AnchorPointY>0.5</sld:AnchorPointY>
      </sld:AnchorPoint>
    </sld:PointPlacement>
  </sld:LabelPlacement>
  <sld:VendorOption name="autoWrap">60</sld:VendorOption>
  <sld:VendorOption name="maxDisplacement">150</sld:VendorOption>
</sld:TextSymbolizer>',null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (3,'bird_directive = true && habitat_directive = false',null,null,'<sld:PolygonSymbolizer>
  <sld:Fill>
    <sld:CssParameter name="fill">#BEE8FF</sld:CssParameter>
    <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
  </sld:Fill>
  <sld:Stroke />
</sld:PolygonSymbolizer>
<sld:TextSymbolizer>
  <sld:Label>
    <ogc:PropertyName>name</ogc:PropertyName>
  </sld:Label>
  <sld:Font>
    <sld:CssParameter name="font-family">RijksoverheidSansText-Bold</sld:CssParameter>
    <sld:CssParameter name="font-size">13</sld:CssParameter>
    <sld:CssParameter name="font-style">normal</sld:CssParameter>
    <sld:CssParameter name="font-weight">bold</sld:CssParameter>
  </sld:Font>
  <sld:LabelPlacement>
    <sld:PointPlacement>
      <sld:AnchorPoint>
        <sld:AnchorPointX>0.5</sld:AnchorPointX>
        <sld:AnchorPointY>0.5</sld:AnchorPointY>
      </sld:AnchorPoint>
    </sld:PointPlacement>
  </sld:LabelPlacement>
  <sld:VendorOption name="autoWrap">60</sld:VendorOption>
  <sld:VendorOption name="maxDisplacement">150</sld:VendorOption>
</sld:TextSymbolizer>',null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (3,'bird_directive = true && habitat_directive = true',null,null,'<sld:PolygonSymbolizer>
  <sld:Fill>
    <sld:CssParameter name="fill">#D1FF73</sld:CssParameter>
    <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
  </sld:Fill>
  <sld:Stroke />
</sld:PolygonSymbolizer>
<sld:TextSymbolizer>
  <sld:Label>
    <ogc:PropertyName>name</ogc:PropertyName>
  </sld:Label>
  <sld:Font>
    <sld:CssParameter name="font-family">RijksoverheidSansText-Bold</sld:CssParameter>
    <sld:CssParameter name="font-size">13</sld:CssParameter>
    <sld:CssParameter name="font-style">normal</sld:CssParameter>
    <sld:CssParameter name="font-weight">bold</sld:CssParameter>
  </sld:Font>
  <sld:LabelPlacement>
    <sld:PointPlacement>
      <sld:AnchorPoint>
        <sld:AnchorPointX>0.5</sld:AnchorPointX>
        <sld:AnchorPointY>0.5</sld:AnchorPointY>
      </sld:AnchorPoint>
    </sld:PointPlacement>
  </sld:LabelPlacement>
  <sld:VendorOption name="autoWrap">60</sld:VendorOption>
  <sld:VendorOption name="maxDisplacement">150</sld:VendorOption>
</sld:TextSymbolizer>',null,null);

INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (4,'bird_directive = false && habitat_directive = true',null,null,'<sld:PolygonSymbolizer>
  <sld:Fill>
    <sld:CssParameter name="fill">#E6E600</sld:CssParameter>
    <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
  </sld:Fill>
  <sld:Stroke />
</sld:PolygonSymbolizer>',null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (4,'bird_directive = true && habitat_directive = false',null,null,'<sld:PolygonSymbolizer>
  <sld:Fill>
    <sld:CssParameter name="fill">#BEE8FF</sld:CssParameter>
    <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
  </sld:Fill>
  <sld:Stroke />
</sld:PolygonSymbolizer>',null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (4,'bird_directive = true && habitat_directive = true',null,null,'<sld:PolygonSymbolizer>
  <sld:Fill>
    <sld:CssParameter name="fill">#D1FF73</sld:CssParameter>
    <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
  </sld:Fill>
  <sld:Stroke />
</sld:PolygonSymbolizer>',null,null);

INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (5,null,null,null,
'<sld:PolygonSymbolizer>
  <sld:Fill>
    <sld:CssParameter name="fill">#FFFFFF</sld:CssParameter>
    <sld:CssParameter name="fill-opacity">0</sld:CssParameter>
  </sld:Fill>
  <sld:Stroke>
    <sld:CssParameter name="stroke">#FFFFFF</sld:CssParameter>
    <sld:CssParameter name="stroke-opacity">0</sld:CssParameter>
  </sld:Stroke>
</sld:PolygonSymbolizer>
<sld:TextSymbolizer>
  <sld:Label>
    <ogc:PropertyName>name</ogc:PropertyName>
  </sld:Label>
  <sld:Graphic>
    <sld:Mark>
      <sld:WellKnownName>square</sld:WellKnownName>
      <sld:Fill>
        <sld:CssParameter name="fill">#FFFFFF</sld:CssParameter>
        <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
      </sld:Fill>
      <sld:Stroke>
        <sld:CssParameter name="stroke">#000000</sld:CssParameter>
      </sld:Stroke>
    </sld:Mark>
  </sld:Graphic>
  <sld:Font>
    <sld:CssParameter name="font-family">RijksoverheidSansText-Bold</sld:CssParameter>
    <sld:CssParameter name="font-size">13</sld:CssParameter>
    <sld:CssParameter name="font-style">normal</sld:CssParameter>
    <sld:CssParameter name="font-weight">normal</sld:CssParameter>
  </sld:Font>
  <sld:LabelPlacement>
    <sld:PointPlacement>
      <sld:AnchorPoint>
        <sld:AnchorPointX>0.5</sld:AnchorPointX>
        <sld:AnchorPointY>0.5</sld:AnchorPointY>
      </sld:AnchorPoint>
    </sld:PointPlacement>
  </sld:LabelPlacement>
  <sld:VendorOption name="graphic-resize">stretch</sld:VendorOption>
  <sld:VendorOption name="graphic-margin">6</sld:VendorOption>
</sld:TextSymbolizer>'
,null,null);

INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (6,null,null,null,
'<sld:PolygonSymbolizer>
  <sld:Fill>
    <sld:CssParameter name="fill">#FFF000</sld:CssParameter>
    <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
  </sld:Fill>
  <Stroke>
    <CssParameter name="stroke">#333333</CssParameter>
    <CssParameter name="stroke-width">0</CssParameter>
  </Stroke>
</sld:PolygonSymbolizer>',null,null);

INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (7,null,null,null,
'<sld:PolygonSymbolizer>
  <sld:Geometry><ogc:PropertyName>geometry</ogc:PropertyName></sld:Geometry>
  <sld:Fill>
    <sld:CssParameter name="fill">#FFF000</sld:CssParameter>
    <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
  </sld:Fill>
  <Stroke>
    <CssParameter name="stroke">#333333</CssParameter>
    <CssParameter name="stroke-width">0</CssParameter>
  </Stroke>
</sld:PolygonSymbolizer>
<PolygonSymbolizer>
  <sld:Geometry><ogc:PropertyName>relevant_geometry</ogc:PropertyName></sld:Geometry>
  <Fill>
    <GraphicFill>
      <Graphic>
        <Mark>
          <WellKnownName>shape://dot</WellKnownName>
          <Stroke>
            <CssParameter name="stroke">#153C6E</CssParameter>
            <CssParameter name="stroke-width">2.5</CssParameter>
            <CssParameter name="stroke-opacity">0.8</CssParameter>
            <CssParameter name="stroke-linejoin">round</CssParameter>
          </Stroke>
        </Mark>
        <Size>8</Size>
      </Graphic>
    </GraphicFill>
  </Fill>
  <Stroke>
    <CssParameter name="stroke">#153C6E</CssParameter>
    <CssParameter name="stroke-width">0</CssParameter>
    <CssParameter name="stroke-opacity">1</CssParameter>
  </Stroke>
</PolygonSymbolizer>',null,null);

INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (8,null,null,null,
'<sld:PolygonSymbolizer>
  <sld:Fill>
    <sld:CssParameter name="fill">#<ogc:PropertyName>color</ogc:PropertyName></sld:CssParameter>
    <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
  </sld:Fill>
  <Stroke>
    <CssParameter name="stroke">#FFFFFF</CssParameter>
    <CssParameter name="stroke-width">0</CssParameter>
  </Stroke>
</sld:PolygonSymbolizer>',null,null);

INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (9,null,null,null,
'<sld:PolygonSymbolizer>
  <sld:Fill>
    <sld:CssParameter name="fill">#<ogc:PropertyName>fill_color</ogc:PropertyName></sld:CssParameter>
    <sld:CssParameter name="fill-opacity">1</sld:CssParameter>
  </sld:Fill>
  <Stroke>
    <CssParameter name="stroke">#<ogc:PropertyName>stroke_color</ogc:PropertyName></CssParameter>
    <CssParameter name="stroke-width">0</CssParameter>
  </Stroke>
</sld:PolygonSymbolizer>',null,null);

INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (11,'deposition >= 0 && deposition < 0.05','FFFDB3','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (11,'deposition >= 0.05 && deposition < 1','FDE76A','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (11,'deposition >= 1 && deposition < 3','FEB66E','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (11,'deposition >= 3 && deposition < 5','A5CC46','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (11,'deposition >= 5 && deposition < 7','23A870','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (11,'deposition >= 7 && deposition < 10','5A7A32','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (11,'deposition >= 10 && deposition < 15','0093BD','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (11,'deposition >= 15 && deposition < 20','0D75B5','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (11,'deposition >= 20 && deposition < 30','6A70B1','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (11,'deposition >= 30 && deposition < 50','304594','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (11,'deposition >= 50 && deposition < 75','7F3B17','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (11,'deposition >= 75 && deposition < 100','5E2C8F','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (11,'deposition >= 100 && deposition < 150','3F2A84','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (11,'deposition >= 150','2A1612','FFFFFF',null,null,null);

INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (12,'delta_deposition < -20',                               '507122','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (12,'delta_deposition < -13   && delta_deposition >= -20',  '65853F','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (12,'delta_deposition < -5    && delta_deposition >= -13',  '84A267','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (12,'delta_deposition < -3    && delta_deposition >= -5',   'A7C296','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (12,'delta_deposition < -1    && delta_deposition >= -3',   'C7DEBE','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (12,'delta_deposition < -0.05 && delta_deposition >= -1',   'E2EFE1','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (12,'delta_deposition > -0.05 && delta_deposition <= 0.05', 'EDEDED','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (12,'delta_deposition > 0.05  && delta_deposition <= 1',    'DED9EF','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (12,'delta_deposition > 1     && delta_deposition <= 3',    'C6BFDD','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (12,'delta_deposition > 3     && delta_deposition <= 5',    'A299C4','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (12,'delta_deposition > 5     && delta_deposition <= 13',   '7A6CA7','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (12,'delta_deposition > 13    && delta_deposition <= 20',   '55438E','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (12,'delta_deposition > 20',                                '3D277C','FFFFFF',null,null,null);

INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (13,'is_line = false',null,null,
'<PointSymbolizer>
  <Graphic>
    <Mark>
      <WellKnownName>circle</WellKnownName>
      <Fill>
        <CssParameter name="fill">transparent</CssParameter>
      </Fill>
      <Stroke>
        <CssParameter name="stroke">#114289</CssParameter>
        <CssParameter name="stroke-width">2</CssParameter>
      </Stroke>
    </Mark>
  <Size>10</Size>
  </Graphic>
</PointSymbolizer>',null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (13,'is_line = true',null,null,'
<LineSymbolizer>
  <Stroke>
    <CssParameter name="stroke">#114289</CssParameter>
    <CssParameter name="stroke-width">3</CssParameter>
    <CssParameter name="stroke-linecap">round</CssParameter>
  </Stroke>
</LineSymbolizer>',null,null);

INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (14,null,null,'808080',null,null,null);

-- new colors
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (15,'delta_deposition < 0.05','FFFDB3','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (15,'delta_deposition >= 0.05 && delta_deposition < 1','FDE76A','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (15,'delta_deposition >= 1 && delta_deposition < 3','FEB66E','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (15,'delta_deposition >= 3 && delta_deposition < 5','A5CC46','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (15,'delta_deposition >= 5 && delta_deposition < 7','23A870','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (15,'delta_deposition >= 7 && delta_deposition < 10','5A7A32','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (15,'delta_deposition >= 10 && delta_deposition < 15','0093BD','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (15,'delta_deposition >= 15 && delta_deposition < 20','0D75B5','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (15,'delta_deposition >= 20 && delta_deposition < 30','6A70B1','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (15,'delta_deposition >= 30 && delta_deposition < 50','304594','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (15,'delta_deposition >= 50 && delta_deposition < 75','7F3B17','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (15,'delta_deposition >= 75 && delta_deposition < 100','5E2C8F','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (15,'delta_deposition >= 100 && delta_deposition < 150','3F2A84','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (15,'delta_deposition >= 150','2A1612','FFFFFF',null,null,null);

INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (16,'delta_deposition_percentage > 90',                                     '000000','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (16,'delta_deposition_percentage > 80 && delta_deposition_percentage <= 90','404040','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (16,'delta_deposition_percentage > 70 && delta_deposition_percentage <= 80','595959','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (16,'delta_deposition_percentage > 60 && delta_deposition_percentage <= 70','6F6F6F','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (16,'delta_deposition_percentage > 50 && delta_deposition_percentage <= 60','828282','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (16,'delta_deposition_percentage > 40 && delta_deposition_percentage <= 50','959595','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (16,'delta_deposition_percentage > 30 && delta_deposition_percentage <= 40','A7A7A7','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (16,'delta_deposition_percentage > 20 && delta_deposition_percentage <= 30','BCBCBC','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (16,'delta_deposition_percentage > 10 && delta_deposition_percentage <= 20','D3D3D3','FFFFFF',null,null,null);
INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (16,'delta_deposition_percentage <= 10','E6E6E6','FFFFFF',null,null,null);

INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (17,null,null,null,'<MaxScaleDenominator>15000</MaxScaleDenominator>
  <sld:TextSymbolizer>
    <sld:Label>
      <ogc:Function name="numberFormat">
        <ogc:Literal>0.##</ogc:Literal>
        <ogc:PropertyName>delta_deposition</ogc:PropertyName>
      </ogc:Function>
      </sld:Label>
      <sld:Font>
    <sld:CssParameter name="font-family">Rijksoverheid SansLF Bold</sld:CssParameter>
    <sld:CssParameter name="font-size">13</sld:CssParameter>
    <sld:CssParameter name="font-style">normal</sld:CssParameter>
    <sld:CssParameter name="font-weight">bold</sld:CssParameter>
  </sld:Font>
  <sld:LabelPlacement>
    <sld:PointPlacement>
      <sld:AnchorPoint>
        <sld:AnchorPointX>0.5</sld:AnchorPointX>
        <sld:AnchorPointY>0.75</sld:AnchorPointY>
      </sld:AnchorPoint>
    </sld:PointPlacement>
  </sld:LabelPlacement>
  <sld:VendorOption name="autoWrap">60</sld:VendorOption>
  </sld:TextSymbolizer>    
',null,null);

INSERT INTO system.sld_rules (sld_id,condition,fill_color,stroke_color,custom_draw_sld,custom_condition_sld,image_url) VALUES (18,null,null,null,'<MaxScaleDenominator>15000</MaxScaleDenominator>
  <sld:TextSymbolizer>
    <sld:Label>
      <ogc:Function name="numberFormat">
        <ogc:Literal>0.##</ogc:Literal>
        <ogc:PropertyName>delta_deposition_percentage</ogc:PropertyName>
      </ogc:Function>
      </sld:Label>
      <sld:Font>
    <sld:CssParameter name="font-family">Rijksoverheid SansLF Bold</sld:CssParameter>
    <sld:CssParameter name="font-size">13</sld:CssParameter>
    <sld:CssParameter name="font-style">normal</sld:CssParameter>
    <sld:CssParameter name="font-weight">bold</sld:CssParameter>
  </sld:Font>
  <sld:LabelPlacement>
    <sld:PointPlacement>
      <sld:AnchorPoint>
        <sld:AnchorPointX>0.5</sld:AnchorPointX>
        <sld:AnchorPointY>0.75</sld:AnchorPointY>
      </sld:AnchorPoint>
    </sld:PointPlacement>
  </sld:LabelPlacement>
  <sld:VendorOption name="autoWrap">60</sld:VendorOption>
  </sld:TextSymbolizer>    
',null,null);