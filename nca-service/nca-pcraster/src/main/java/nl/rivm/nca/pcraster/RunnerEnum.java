package nl.rivm.nca.pcraster;

import nl.rivm.nca.runner.OSUtils;

public enum RunnerEnum {
  /*
   * this script runs the actual model based on ini input files.
   * It will run a full model run for baseline, scenario and determines the difference
   * script runs a docker file to process the model
   */
  NCA("nca"),
  /*
   * this script runs the actual model based on generated ini input files.
   * It will only run the scenario model and determines the differnce
   * script runs a docker file to process the model
   */
  NCA_SCENARIO("nca_scenario"),
  /*
   * this script runs the actual model based on generated ini input files.
   * It will only run the baseline models
   * script runs a docker file to process the model
   */
  NCA_BASELINE("nca_baseline"),
  /*
   * this script runs a preprocess step to correct the input
   */
  NCA_PREPROCESS("nca_preprocess_scenario_map"),
  /*
   * this script runs gdal_translate 
   * script runs a docker file to run gdal_translate
   */
  GDAL_TRANSLATE("nca_gdal_translate"),
  /*
   * this script runs gdal_translate 
   * script runs a docker file to run gdal_translate
   */
  OGR2OGR("nca_ogr2ogr"),
  /*
   * this script runs gdal_rasterize 
   * will convert geojson to tiff
   * script runs a docker file to run gdal_translate
   */
  GDAL_RASTERIZE("nca_gdal_rasterize");

  private final String script;

  private RunnerEnum(final String script) {
    this.script = script;
  }

  private String getScript() {
    return script;
  }

  public String getRunner() {
    final String WIN = ".bat";
    final String UNIX = ".sh";
    final String runnerFile = getScript() + (OSUtils.isWindows() ? WIN : UNIX);
    return EnvironmentEnum.NCA_MODEL_RUNNER.getEnv()+ "/" + runnerFile;
  }
  
  public String getRunner(String path) {
    final String WIN = ".bat";
    final String UNIX = ".sh";
    final String runnerFile = getScript() + (OSUtils.isWindows() ? WIN : UNIX);
    return path + "/" + runnerFile;
  }

}
