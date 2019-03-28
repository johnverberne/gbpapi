/*
 * Copyright Dutch Ministry of Economic Affairs
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see http://www.gnu.org/licenses/.
 */
package nl.rivm.nca.shared.domain;

import java.io.Serializable;
import java.util.Date;

import nl.rivm.nca.shared.domain.calculation.JobState;

public class JobProgress implements Serializable {

	private static final long serialVersionUID = 2439541939254337039L;

	private JobType type;
	private String key;
	private String name;
	private JobState state;
	private long progressCount;
	private long maxProgress;
	private Date creationDateTime;
	private Date startDateTime;
	private Date endDateTime;
	private String resultUrl;

	public JobType getType() {
		return type;
	}

	public void setType(final JobType type) {
		this.type = type;
	}

	public JobState getState() {
		return state;
	}

	public void setState(final JobState state) {
		this.state = state;
	}

	public Date getCreationDateTime() {
		return creationDateTime;
	}

	public void setCreationDateTime(final Date creationDateTime) {
		this.creationDateTime = creationDateTime;
	}

	public Date getStartDateTime() {
		return startDateTime;
	}

	public void setStartDateTime(final Date startDateTime) {
		this.startDateTime = startDateTime;
	}

	public Date getEndDateTime() {
		return endDateTime;
	}

	public void setEndDateTime(final Date endDateTime) {
		this.endDateTime = endDateTime;
	}

	public String getResultUrl() {
		return resultUrl;
	}

	public void setResultUrl(final String resultUrl) {
		this.resultUrl = resultUrl;
	}

	public String getKey() {
		return key;
	}

	public void setKey(final String key) {
		this.key = key;
	}

	public String getName() {
		return name;
	}

	public void setName(final String name) {
		this.name = name;
	}

	public long getProgressCount() {
		return progressCount;
	}

	public void setProgressCount(long progressCount) {
		this.progressCount = progressCount;
	}

	public long getMaxProgress() {
		return maxProgress;
	}

	public void setMaxProgress(long maxProgress) {
		this.maxProgress = maxProgress;
	}

	@Override
	public String toString() {
		return "JobProgress [type=" + type + ", key=" + key + ", name=" + name + ", state=" + state + ", progressCount="
				+ progressCount + ", maxProgress=" + maxProgress + ", creationDateTime=" + creationDateTime + ", "
				+ "startDateTime=" + startDateTime + ", endDateTime=" + endDateTime + ", resultUrl=" + resultUrl + "]";
	}

}
