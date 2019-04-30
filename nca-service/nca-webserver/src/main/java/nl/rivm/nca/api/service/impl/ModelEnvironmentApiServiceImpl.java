package nl.rivm.nca.api.service.impl;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.Layer;
import nl.rivm.nca.api.domain.ModelDataResponse;
import nl.rivm.nca.api.domain.ModelEnvironmentResponse;
import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.api.service.ModelEnvironmentApiService;
import nl.rivm.nca.api.service.ModeldataApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.api.service.util.WarningUtil;
import nl.rivm.nca.pcraster.RasterLayers;

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
//      envList.add("database " + connection.toString());
//      //    }
    envList.add("database");
    envList.add("database not tested!");
    // System.getenv("GEOSERVER_PASSWORD"
    envList.add("nca appliation");
    envList.add("GEOSERVER_URL : " + System.getenv("GEOSERVER_URL"));
    envList.add("GEOSERVER_USER  : " + System.getenv("GEOSERVER_USER"));
    envList.add("NCA_MODEL : " + System.getenv("NCA_MODEL"));
    envList.add("all enviroments");
    StringBuilder sb = new StringBuilder(); 
    Map<String, String> env = System.getenv(); 
    for (String key : env.keySet()) { 
      String value = env.get(key);
     envList.add(key+ ": " + (key.toLowerCase().contains("pass") ? "*secret*" : env.get(key)));
    } 
    response.setEntries(envList);
    return Response.ok().entity(response).build();
  }

}
