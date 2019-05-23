package nl.rivm.nca.pcraster;

public class EnvironmentConstants {
 
  /*
   * location of the nca modellen the python scripts to run the model
   * d:\nkmodel\raster\nederland
   * d:\nkmodel\NatuurlijkKapitaalModellen
   * d:\nkmodel\nca [sh|bat]
   * d:\nkmodel\nca2 [sh|bat]
   * d:\nkmodel\nca_preprocess_scenarion_map [sh|bat]
   */
  public static final String NCA_MODEL = "NCA_MODEL";

  /*
   * username for geoserver
   */
  public static final String GEOSERVER_USER = "GEOSERVER_USER";
  
  /*
   * password username for geoserver
   */
  public static final String GEOSERVER_PASSWORD = "GEOSERVER_PASSWORD";
  
  /*
   * url endpoint for geoserver to publisch result layers
   */
  public static final String GEOSERVER_URL = "GEOSERVER_URL";
  
  /*
   * location for the frontend application to get the output of the scenario run
   */
  public static final String NCA_DOWNLOAD_URL = "NCA_DOWNLOAD_URL";
  
  /*
   * location for the frontend application to write output for download
   */
  public static final String NCA_DOWNLOAD_PATH = "NCA_DOWNLOAD_PATH";
}
