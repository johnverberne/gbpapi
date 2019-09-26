package nl.rivm.nca.pcraster;

public enum EnvironmentEnum {

  /*
   * Directory with raster files.
   * /opt/nkmodel/raster/nederland [unix]
   */
  NCA_MODEL_RASTER,
  /*
   * Directory with different runner shell and batch files.
   * d:\opt\nkmodel [windowns]
   * /opt/nkmodel [unix]
   */
  NCA_MODEL_RUNNER, GEOSERVER_USER, GEOSERVER_PASSWORD,
  /*
   * url endpoint for geoserver to publisch result layers.
   */
  GEOSERVER_URL,
  /*
   * url endpoint for geoserver to publisch result layers.
   */
  NCA_DOWNLOAD_URL,
  /*
   * location for the frontend application to write output for download.
   */
  NCA_DOWNLOAD_PATH;

  public String getEnv() {
    return System.getenv(this.toString());
  }
}
