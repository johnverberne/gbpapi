package nl.rivm.nca.api.service.impl;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.JobState;
import nl.rivm.nca.api.domain.StatusJobProgress;
import nl.rivm.nca.api.domain.StatusJobResponse;
import nl.rivm.nca.api.domain.ValidateResponse;
import nl.rivm.nca.api.domain.ValidationMessage;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.StatusApiService;
import nl.rivm.nca.api.service.domain.ApiServiceContext;
import nl.rivm.nca.api.service.util.AeriusExceptionConversionUtil;
import nl.rivm.nca.api.service.util.SwaggerUtil;
import nl.rivm.nca.api.service.util.UserUtil;
import nl.rivm.nca.api.service.util.WarningUtil;
import nl.rivm.nca.db.user.JobRepository;
import nl.rivm.nca.exception.AeriusException;
import nl.rivm.nca.shared.domain.JobProgress;
import nl.rivm.nca.shared.domain.user.ScenarioUser;

public class StatusApiServiceImpl extends StatusApiService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(StatusApiServiceImpl.class);

	private final ApiServiceContext context;

	public StatusApiServiceImpl() {
		this(new ApiServiceContext());
	}

	StatusApiServiceImpl(final ApiServiceContext context) {
		this.context = context;
	}

	@Override
	public Response getStatusJobs(String apiKey, SecurityContext securityContext) throws NotFoundException {
	    try {
	        return Response.ok(jobs(apiKey)).build();
	      } catch (final AeriusException e) {
	        return SwaggerUtil.handleException(context, e);
	      }
	}

	private StatusJobResponse jobs(String apiKey) throws AeriusException  {
		StatusJobResponse result = new StatusJobResponse();
		 
		try (final Connection con = context.getPMF().getConnection()) {
			result = new StatusJobResponse();
			ScenarioUser user = UserUtil.getUser(con, apiKey, false);
			List<JobProgress> entries = JobRepository.getProgressForUser(con, user);
			result.entries(convert(entries));

			 // catching exception is allowed here
		} catch (Exception e) {
			LOGGER.error("Fetching the status of jobs failed:", e);
		      throw AeriusExceptionConversionUtil.convert(e, context);

		}
		return result;
	}

	private List<StatusJobProgress> convert(final List<JobProgress> collection) {
		final List<StatusJobProgress> progresses = new ArrayList<>();
		for (final JobProgress item : collection) {
			progresses.add(convert(item));
		}
		return progresses;
	}

	private StatusJobProgress convert(final JobProgress value) {
		return new StatusJobProgress()
				.name(value.getName())
				.startDateTime(value.getStartDateTime())
				.endDateTime(value.getEndDateTime())
				.state(getState(value))
				.key(value.getKey())
				.progressCount(value.getProgressCount())
				.maxProgress(value.getMaxProgress());
	}

	private JobState getState(final JobProgress value) {
		JobState state = JobState.QUEUED;

		if (value.getState() != null) {
			switch (value.getState()) {
			case RUNNING:
				state = JobState.RUNNING;
				break;
			case CANCELLED:
				state = JobState.CANCELLED;
				break;
			case COMPLETED:
				state = JobState.COMPLETED;
				break;
			case UNDEFINED:
			case INITIALIZED:
			default:
				break;
			}
		}

		return state;
	}

}