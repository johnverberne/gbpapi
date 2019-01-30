/*
 * Het setup-schema bevat basis-tabellen, qeuries en functies om afgeleide aerius-tabellen te maken.
 * In de setup worden (wegens performance redenen) (afgeleide) tussentabellen aangemaakt.
 */
CREATE SCHEMA setup;

/*
 * system
 * ------
 * Het system-schema bevat basis-tabellen voor de AERIUS applicatie.
 */
CREATE SCHEMA system;

/*
 * opendata
 * --------
 * Het opendata-schema bevat alle opendata base-views voor de opendata services (WMS/WFS) die aangeboden worden.
 *
 * De opendata services mogen enkel gebruik maken van views uit dit schema.
 */
CREATE SCHEMA opendata;

/*
 * i18n
 * ----
 * Het i18n-schema bevat tabellen met vertalingen van database items. Bijvoorbeeld sectoren.
 */
CREATE SCHEMA i18n;

/*
 * dataservice
 * -----------
 * Dit dataservice-schema bevat alle synchronisatie-views voor de AERIUS data-service.
 */
CREATE SCHEMA dataservice;
