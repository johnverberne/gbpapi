package nl.rivm.nca.api.service.impl;

import java.io.IOException;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import org.apache.commons.configuration2.ex.ConfigurationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.AssessmentTKSRequestResponse;
import nl.rivm.nca.api.domain.MeasureCollection;
import nl.rivm.nca.api.domain.MeasureCollectionDataResponse;
import nl.rivm.nca.api.service.MeasureCollectiondataApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.api.service.util.AeriusExceptionConversionUtil;
import nl.rivm.nca.api.service.util.SwaggerUtil;
import nl.rivm.nca.shared.exception.AeriusException;
import nl.rivm.nca.shared.exception.AeriusException.Reason;
import nl.rivm.nca.tks.pcraster.NkModelTKSController;
import nl.rivm.nca.tks.pcraster.TksMeasures;

public class MeasureCollectiondataApiServiceImpl extends MeasureCollectiondataApiService {

  private static final Logger LOGGER = LoggerFactory.getLogger(MeasureCollectiondataApiServiceImpl.class);

  private final ApiServiceContext context;

  public MeasureCollectiondataApiServiceImpl() {
    this(new ApiServiceContext());
  }

  MeasureCollectiondataApiServiceImpl(final ApiServiceContext context) {
    this.context = context;
  }

  @Override
  public Response getMeasureCollectionData(final SecurityContext securityContext) throws NotFoundException {
    try {
      MeasureCollectionDataResponse response = new MeasureCollectionDataResponse();
      response = getCollection();
      response.setName("Current supported measures");
      response.setVersion("1.0.0");
      return Response.ok().entity(response).build();
    } catch (AeriusException e) {
      return SwaggerUtil.handleException(context, e);
    }
  }
  
  private MeasureCollectionDataResponse getCollection() throws AeriusException {  
    MeasureCollectionDataResponse response = new MeasureCollectionDataResponse();
    try {
      response.setEntries(TksMeasures.loadRunable());
    } catch (IOException e) {
      LOGGER.error("Measure datafile ({}) could not be retrieved", TksMeasures.getEnvironment());
      throw new AeriusException(Reason.INTERNAL_ERROR);
    }
    
    return response;
  }

}
