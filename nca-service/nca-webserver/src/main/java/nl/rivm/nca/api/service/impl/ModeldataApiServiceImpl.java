package nl.rivm.nca.api.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.Layer;
import nl.rivm.nca.api.domain.ModelDataResponse;
import nl.rivm.nca.api.service.ModeldataApiService;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.pcraster.RasterLayers;

public class ModeldataApiServiceImpl extends ModeldataApiService {

	private static final Logger LOGGER = LoggerFactory.getLogger(ModeldataApiServiceImpl.class);

	private final ApiServiceContext context;

	public ModeldataApiServiceImpl() {
			this(new ApiServiceContext());
		}

	ModeldataApiServiceImpl(final ApiServiceContext context) {
			this.context = context;
		}

	@Override
	public Response getModelData(String model, SecurityContext securityContext)
			throws NotFoundException {
		RasterLayers rasterLayer = RasterLayers.loadRasterLayers(null);
	    ModelDataResponse response = new ModelDataResponse();
	    List<Layer> layers = new ArrayList<>(rasterLayer.getLayerFiles(model).keySet());
	    response.setEntries(layers);
	    response.setVersion("1.0.0");
	    response.setName(model);
	    return Response.ok().entity(response).build();
	}

}
