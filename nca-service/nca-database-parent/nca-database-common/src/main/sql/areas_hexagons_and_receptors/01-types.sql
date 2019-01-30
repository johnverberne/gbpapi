/*
 * assessment_area_type
 * --------------------
 * Type van een toetsgebied
 */
CREATE TYPE assessment_area_type AS ENUM
	('natura2000_area', 'natura2000_directive_area');


/*
 * critical_deposition_area_type
 * -----------------------------
 * Type van een KDW-gebied
 */
CREATE TYPE critical_deposition_area_type AS ENUM
	('relevant_habitat', 'habitat');


/*
 * natura2000_directive_type
 * -------------------------
 * Beschermstatus van een deelgebied van een Natura 2000 gebied.
 * - Vogelrichtlijn
 * - Habitatrichtlijn
 * - Beschermd natuurgebied
 */
CREATE TYPE natura2000_directive_type AS ENUM
	('VR', 'VR+BN', 'VR+HR', 'VR+HR+BN', 'HR', 'HR+BN');


/*
 * habitat_goal_type
 * -----------------
 * Doelstelling voor oppervlakte en/of kwaliteit (in de context van habitattypes):
 * =       behoud
 * >       uitbreiding
 * = (>)   uitbreiding met behoud van de goed ontwikkelde locaties
 * <       vermindering is toegestaan, ten gunste van met name genoemde habitattype
 * = (<)   achteruitgang ten gunste van ander habitattype toegestaan
 * > (<)   oppervlak staat in principe op uitbreiding, maar mag achteruit gaan ten gunste van ander habitattype
 *
 * Doelstelling voor leefgebied en/of omvang populatie (in de context van soorten, broedvogels, niet-broedvogels):
 * =       behoud
 * >       uitbreiding/verbetering
 * <       vermindering is toegestaan
 * = (<)   achteruitgang ten gunste van andere soort toegestaan
 *
 * Zie legenda http://www.synbiosys.alterra.nl/natura2000/gebiedendatabase.aspx?subj=n2k&groep=6&id=n2k65&topic=doelstelling
 */
CREATE TYPE habitat_goal_type AS ENUM
	('specified', 'none', 'level', 'increase', 'level_increase', 'decrease', 'level_decrease', 'increase_may_decrease');


/*
 * ecology_quality_type
 * --------------------
 * Categorising van de kwaliteit van een habitattype (= habitattype categorie) of een natura2000 gebied.
 *
 * -----
 * Om de ecologische haalbaarheid van de doelen op een juridisch relevante wijze weer weer
 * te geven, zijn de volgende categorieen opgesteld:
 *
 * Categorie 1 Wetenschappelijk gezien redelijkerwijs geen twijfel dat ISHD niet in gevaar komen.
 *     Binnen deze categorie zijn twee subcategorieen te onderscheiden:
 *     1a. Wetenschappelijk gezien is redelijkerwijs geen twijfel dat de
 *         instandhoudingsdoelstellingen niet gevaar komen, waarbij behoud
 *         is geborgd en, indien relevant, ook verbetering dan wel uitbreiding
 *         plaats gaat vinden.
 *     1b. Wetenschappelijk gezien is redelijkerwijs geen twijfel dat de
 *         instandhoudingsdoelstellingen niet in gevaar komen waarbij
 *         behoud is geborgd en een toekomstige verbetering /uitbreiding
 *         niet onmogelijk is.
 * Categorie 2 Wetenschappelijk gezien redelijkerwijs twijfel dat ISHD niet in gevaar komen.
 *     Er zijn wetenschappelijk gezien te grote twijfels of de achteruitgang
 *     gestopt zal worden en er uitbreiding van de oppervlakte en/of verbeteren
 *     van de kwaliteit van de habitats plaats zal gaan vinden.
 *
 * Deze categorieen zijn toegekend per habitattype, maar ook aan de gebieden als geheel.
 * Hierbij is het het meest kritische habitat dat de uiteindelijke gebiedsscore bepaalt.
 *
 * Bron: pas.natura2000.nl/files/eindrapport-pas-fase-iii.pdf
 * -----
 */
CREATE TYPE ecology_quality_type AS ENUM
	('irrelevant', '1a', '1b', '2', 'unknown');


/*
 * landscape_type
 * --------------
 * Landschapstype (van een N2000 gebied).
 */
CREATE TYPE landscape_type AS ENUM
	('Beekdalen', 'Duinen', 'Heuvelland', 'Hoogvenen', 'Hogere Zandgronden', 'Hogere Zandgronden, Rivierengebied', 'Meren en Moerassen', 'Noordzee, Waddenzee en Delta', 'Rivierengebied', 'Hogere zandgronden en Hoogvenen');


/*
 * land_use_classification
 * -----------------------
 * Klasseindeling voor landgebruik
 */
CREATE TYPE land_use_classification AS ENUM
	('grasland', 'bouwland', 'vaste gewassen', 'naaldbos', 'loofbos', 'water', 'bebouwing', 'overige natuur', 'kale grond');


/*
 * species_type
 * ------------
 * Type van een (dier)soort welke in een leefgebied voorkomt.
 * Resp. habitatsoorten, broedvogelsoorten en niet-broedvogelsoorten.
 */
CREATE TYPE species_type AS ENUM
	('habitat_species', 'breeding_bird_species', 'non_breeding_bird_species');


/*
 * authority_type
 * --------------
 * Type van een bevoegd gezag.
 * Let op dat de volgorde van deze enum ook bepaalt hoe de entries in de authorities tabel gesorteerd
 * worden bij weergave in de UI (bijvoorbeeld in een dropdown box).
 */
CREATE TYPE authority_type AS ENUM
	('unknown', 'province', 'ministry', 'foreign');
