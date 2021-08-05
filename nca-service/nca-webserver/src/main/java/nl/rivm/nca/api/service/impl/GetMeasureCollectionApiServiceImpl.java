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

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import nl.rivm.nca.api.domain.MeasureCollection;
import nl.rivm.nca.api.domain.MeasureCollectionsResponse;
import nl.rivm.nca.api.domain.MeasureResponse;
import nl.rivm.nca.api.service.GetMeasureCollectionApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.api.service.util.AeriusExceptionConversionUtil;
import nl.rivm.nca.api.service.util.SwaggerUtil;
import nl.rivm.nca.api.service.util.UserUtil;
import nl.rivm.nca.db.measures.MeasuresRepository;
import nl.rivm.nca.pcraster.Measures;
import nl.rivm.nca.shared.domain.measure.ModelMeasure;
import nl.rivm.nca.shared.domain.user.ScenarioUser;
import nl.rivm.nca.shared.exception.AeriusException;

public class GetMeasureCollectionApiServiceImpl extends GetMeasureCollectionApiService {

  static private final ObjectMapper mapper = new ObjectMapper();

  private static final Logger LOGGER = LoggerFactory.getLogger(GetMeasureCollectionApiServiceImpl.class);

  private final ApiServiceContext context;

  public GetMeasureCollectionApiServiceImpl() {
    this(new ApiServiceContext());
  }

  GetMeasureCollectionApiServiceImpl(final ApiServiceContext context) {
    this.context = context;
  }

  @Override
  public Response getMeasureCollection(String apiKey, SecurityContext securityContext) throws NotFoundException {
    MeasureCollectionsResponse response;
    try {
      response = measureCollection(apiKey);
    } catch (AeriusException e) {
      return SwaggerUtil.handleException(context, e);
    }
    return Response.ok().entity(response).build();
  }

  private MeasureCollectionsResponse measureCollection(String apiKey) throws AeriusException {
    MeasureCollectionsResponse response = new MeasureCollectionsResponse();
    try {
      final ScenarioUser user;
      try (final Connection con = context.getPMF().getConnection()) {
        user = UserUtil.getUser(con, apiKey);
      }

      response.setEntries(getEntries(user));

    } catch (Exception e) {
      LOGGER.error("MeasureCollection export failed:", e);
      throw AeriusExceptionConversionUtil.convert(e, context.getLocale());
    }
    return response;
  }

  private List<MeasureResponse> getEntries(final ScenarioUser user) throws IOException, SQLException, AeriusException {
    List<MeasureResponse> entries = new ArrayList<MeasureResponse>();
    // add the default as first row
    MeasureResponse defaultRow = new MeasureResponse();
    defaultRow.setEntries(Measures.load().getMeasures());
    defaultRow.setKey("default");
    defaultRow.setName("default measures");
    defaultRow.setVersion("1");
    defaultRow.setEnabled(true);
    entries.add(defaultRow);
    try (final Connection con = context.getPMF().getConnection()) {
      List<ModelMeasure> measures = MeasuresRepository.getAllMeasuresByUser(con, user.getId());
      for (ModelMeasure measure : measures) {
        MeasureCollection coll = convertMeasures(measure.getMeasures());
        MeasureResponse row = new MeasureResponse();
        row.setEntries(coll.getMeasures());
        row.setKey(measure.getKey());
        row.setName(measure.getName());
        row.setVersion(measure.getVersion());
        row.setEnabled(measure.isEnabled());
        entries.add(row);
      }
    }
    return entries;
  }

  private MeasureCollection convertMeasures(String body) throws JsonParseException, JsonMappingException, IOException {
    mapper.configure(JsonParser.Feature.ALLOW_NON_NUMERIC_NUMBERS, true);
    mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
    return mapper.readValue(body, MeasureCollection.class);
  }

}
