package nl.rivm.nca.api.service.impl;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.ValidateResponse;
import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.api.service.DeleteMeasureCollectionApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.api.service.util.AeriusExceptionConversionUtil;
import nl.rivm.nca.api.service.util.MeasureUtil;
import nl.rivm.nca.api.service.util.SwaggerUtil;
import nl.rivm.nca.api.service.util.UserUtil;
import nl.rivm.nca.db.PMF;
import nl.rivm.nca.db.measures.MeasuresRepository;
import nl.rivm.nca.shared.domain.user.ScenarioUser;
import nl.rivm.nca.shared.exception.AeriusException;

public class DeleteMeasureCollectionApiServiceImpl extends DeleteMeasureCollectionApiService {

  private static final Logger LOGGER = LoggerFactory.getLogger(DeleteMeasureCollectionApiServiceImpl.class);

  private final ApiServiceContext context;

  public DeleteMeasureCollectionApiServiceImpl() {
    this(new ApiServiceContext());
  }

  DeleteMeasureCollectionApiServiceImpl(final ApiServiceContext context) {
    this.context = context;
  }

  @Override
  public Response deleteMeasureCollection(String apiKey, String measureKey, SecurityContext securityContext) throws NotFoundException {
    try {
      return Response.ok().entity(deleteMeasure(apiKey, measureKey)).build();
    } catch (final AeriusException e) {
      return SwaggerUtil.handleException(context, e);
    }
  }

  
  private Object deleteMeasure(String apiKey, String measureKey) throws AeriusException {
    ValidateResponse response = new ValidateResponse().successful(Boolean.FALSE);
    List<ValidationMessage> warnings = new ArrayList<>();
    List<ValidationMessage> errors = new ArrayList<>();
    response.setErrors(errors);
    response.setWarnings(warnings);
    
    try {
      final ScenarioUser user;
      final PMF pmf = context.getPMF();
      try (final Connection con = pmf.getConnection()) {
        user = UserUtil.getUser(con,  apiKey);
        MeasureUtil.validateMeasure(con, user, measureKey);
      }
      deleteByKey(measureKey);
      response.successful(true);
    } catch (Exception e) {
      LOGGER.error("Delete existing measure collection failed:", e);
      throw AeriusExceptionConversionUtil.convert(e, context);
    }
    return response;
  }
  
  private boolean deleteByKey(final String measureKey)throws IOException, SQLException, AeriusException {
    try (final Connection con = context.getPMF().getConnection()) {
      return MeasuresRepository.removeMeasure(con, measureKey);
   }
  }

}
