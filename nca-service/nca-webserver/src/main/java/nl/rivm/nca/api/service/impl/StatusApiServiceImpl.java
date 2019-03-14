package nl.rivm.nca.api.service.impl;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;

import nl.rivm.nca.api.domain.StatusJobResponse;
import nl.rivm.nca.api.domain.ValidateResponse;
import nl.rivm.nca.api.service.NotFoundException;
import nl.rivm.nca.api.service.StatusApiService;
import nl.rivm.nca.api.service.util.WarningUtil;

public class StatusApiServiceImpl extends StatusApiService {
	@Override
	public Response getStatusJobs(String apiKey, SecurityContext securityContext) throws NotFoundException {
		return Response.ok().entity(jobs(apiKey)).build();
	}

	private ValidateResponse jobs(String apiKey) {
		
//		StatusJobResponse result = new StatusJobResponse();
//		user = UserUtil.getUser(con, apiKey, false);
//		entries = JobRepository.getProgressForUsers(con, user);
//		resut..entries(convert(entries));
		
		final ValidateResponse result = new ValidateResponse().successful(Boolean.FALSE);
		result.setWarnings(WarningUtil.WarningValidationMessageNoImplementation());
		return result;
	}

	
	/*
	private List<StatusJobProgress> convert(final List<JobProgress> collection) {
		final List<StatusJobProgress> progresses = new ArrayList<>();

		for (final JobProgress item : collection) {
			progresses.add(convert(item));
		}

		return progresses;
	}

	private StatusJobProgress convert(final JobProgress value) {
		return new StatusJobProgress().name(value.getName()).startDateTime(value.getStartDateTime())
				.endDateTime(value.getEndDateTime()).hectareCalculated(value.getHexagonCount()).state(getState(value))
				.type(JobType.valueOf(value.getType().name())).key(value.getKey()).resultUrl(value.getResultUrl());
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
	*/

}