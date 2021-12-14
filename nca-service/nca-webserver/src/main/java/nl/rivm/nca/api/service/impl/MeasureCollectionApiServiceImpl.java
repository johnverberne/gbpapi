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

import com.google.gson.Gson;

import nl.rivm.nca.api.domain.MeasureCollection;
import nl.rivm.nca.api.domain.MeasureDataRequest;
import nl.rivm.nca.api.domain.ValidateResponse;
import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.api.service.MeasureCollectionApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.api.service.util.AeriusExceptionConversionUtil;
import nl.rivm.nca.api.service.util.SwaggerUtil;
import nl.rivm.nca.api.service.util.UserUtil;
import nl.rivm.nca.db.measures.MeasuresRepository;
import nl.rivm.nca.shared.domain.measure.ModelMeasure;
import nl.rivm.nca.shared.domain.user.ScenarioUser;
import nl.rivm.nca.shared.exception.AeriusException;
import nl.rivm.nca.shared.exception.AeriusException.Reason;

public class MeasureCollectionApiServiceImpl extends MeasureCollectionApiService {

  private static final Logger LOGGER = LoggerFactory.getLogger(MeasureCollectionApiServiceImpl.class);

  private final ApiServiceContext context;

  public MeasureCollectionApiServiceImpl() {
    this(new ApiServiceContext());
  }

  MeasureCollectionApiServiceImpl(final ApiServiceContext context) {
    this.context = context;
  }
  
  @Override
  public Response postMeasureCollection(String apiKey, MeasureDataRequest measure, SecurityContext securityContext) throws NotFoundException {
    try {
      return Response.ok().entity(saveMeasure(apiKey, measure)).build();
    } catch (final AeriusException e) {
      return SwaggerUtil.handleException(context, e);
    }
  }

  private ValidateResponse saveMeasure(String apiKey, MeasureDataRequest measure) throws NotFoundException, AeriusException {
    ValidateResponse response = new ValidateResponse().successful(Boolean.FALSE);
    List<ValidationMessage> warnings = new ArrayList<>();
    List<ValidationMessage> errors = new ArrayList<>();
    response.setErrors(errors);
    response.setWarnings(warnings);
    
    try {
      final ScenarioUser user;
      try (final Connection con = context.getPMF().getConnection()) {
        user = UserUtil.getUser(con,  apiKey);        
        String lookupMeasure = MeasuresRepository.getMeasuresByUser(con, user.getId(), measure.getMeasureKey().toUpperCase());
        if (lookupMeasure != null) {
          throw new AeriusException(Reason.CALCULATION_MEASURE_NAME_ALREADY_EXISTS, measure.getMeasureKey());     
        }
      }
      saveMeasureForUser(user, measure);      
      response.successful(true);
    } catch (Exception e) {
      LOGGER.error("Post new measure collection failed:", e);
      throw AeriusExceptionConversionUtil.convert(e, context);
    }
    return response;
  }
  
  private void saveMeasureForUser(final ScenarioUser user, final MeasureDataRequest measure) throws IOException, SQLException, AeriusException {
    try (final Connection con = context.getPMF().getConnection()) {
      ModelMeasure model = new ModelMeasure();
      model.setKey(measure.getMeasureKey().toUpperCase());
      model.setName(measure.getName());
      model.setUser_id(user.getId());
      model.setVersion(measure.getVersion());
      MeasureCollection measureCollection = new MeasureCollection();
      measureCollection.setMeasures(measure.getEntries());
      model.setMeasures(new Gson().toJson(measureCollection));
      MeasuresRepository.createMeasure(con, model);
    }
  }

}
