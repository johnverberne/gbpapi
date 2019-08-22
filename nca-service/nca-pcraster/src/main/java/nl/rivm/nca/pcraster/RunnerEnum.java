package nl.rivm.nca.pcraster;

import nl.rivm.nca.runner.OSUtils;

public enum RunnerEnum {
  /*
   * this script runs the actual model based on ini input files.
   * it is used to process geotiff input
   * script runs a docker file to process the model
   */
  NCA("nca"),
  /*
   * this script runs the actual model based on generated ini input files.
   * it is used to process xyz input
   * script runs a docker file to process the model
   */
  NCA2("nca2"),
  /*
   * this script runs a preprocess step to correct the input
   */
  NCA_PREPROCESS("nca_preprocess_scenario_map"),
  /*
   * this script runs gdal_translate 
   * script runs a docker file to run gdal_translate
   */
  GDAL_TRANSLATE("nca_gdal_translate");

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

}
