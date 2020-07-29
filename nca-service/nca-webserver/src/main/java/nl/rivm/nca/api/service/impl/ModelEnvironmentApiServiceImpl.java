package nl.rivm.nca.api.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.ModelEnvironmentResponse;
import nl.rivm.nca.api.service.ModelEnvironmentApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.pcraster.EnvironmentEnum;

public class ModelEnvironmentApiServiceImpl extends ModelEnvironmentApiService {

  private static final Logger LOGGER = LoggerFactory.getLogger(ModelEnvironmentApiServiceImpl.class);

  private final ApiServiceContext context;

  public ModelEnvironmentApiServiceImpl() {
    this(new ApiServiceContext());
  }

  ModelEnvironmentApiServiceImpl(final ApiServiceContext context) {
    this.context = context;
  }

  @Override
  public Response getModelEnvironment(SecurityContext securityContext) throws NotFoundException {
    ModelEnvironmentResponse response = new ModelEnvironmentResponse();
    List<String> envList = new ArrayList<>();
    //    try  (final Connection connection = context.getPMF().getConnection()) {
    //    envList.add("database " + connection.toString());
    //    }
    //envList.add("database");
    //envList.add("connection to database not tested!");
    envList.add("nca appliation");
    envList.add("GEOSERVER_URL : " + EnvironmentEnum.GEOSERVER_URL.getEnv());
    envList.add("GEOSERVER_USER  : " + EnvironmentEnum.GEOSERVER_USER.getEnv());
    envList.add("NCA_MODEL_RASTER : " + EnvironmentEnum.NCA_MODEL_RASTER.getEnv());
    envList.add("NCA_MODEL_RUNNER : " + EnvironmentEnum.NCA_MODEL_RUNNER.getEnv());
    envList.add("all enviroments");
    Map<String, String> env = System.getenv();
    for (String key : env.keySet()) {
      // hide secrets
      envList.add(key + ": " + (key.toLowerCase().contains("pass") ? "*secret*" : env.get(key)));
    }
    response.setEntries(envList);
    return Response.ok().entity(response).build();
  }

}
