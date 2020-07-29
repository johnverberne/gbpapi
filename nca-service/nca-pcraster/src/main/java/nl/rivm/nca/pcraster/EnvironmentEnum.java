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
   * Directory with runner files unix shell and windows batch files
   * Specific for the tks implementation
   */
  NCA_MODEL_TKS_RUNNER,
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
  NCA_DOWNLOAD_PATH,
  /*
   * json file with measure type and effected layer changes
   */
  NCA_TKS_MEASURES;

  public String getEnv() {
    return System.getenv(this.toString());
  }
}
