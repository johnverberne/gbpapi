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
package nl.rivm.nca.shared.domain.user;

import java.io.Serializable;

import nl.rivm.nca.shared.domain.HasId;

/**
 * Data object of a user profile for Scenario.
 */
public class ScenarioUser implements HasId, Serializable {

  private static final long serialVersionUID = 158544847778890161L;

  private int id;
  private boolean enabled = true;
  private String emailAddress;
  private String apiKey;
  private int maxConcurrentJobs;

  @Override
  public int getId() {
    return id;
  }

  @Override
  public void setId(final int id) {
    this.id = id;
  }

  public boolean isEnabled() {
    return enabled;
  }

  public void setEnabled(final boolean enabled) {
    this.enabled = enabled;
  }

  public String getApiKey() {
    return apiKey;
  }

  public void setApiKey(final String apiKey) {
    this.apiKey = apiKey;
  }

  public String getEmailAddress() {
    return emailAddress;
  }

  public void setEmailAddress(final String emailAddress) {
    this.emailAddress = emailAddress;
  }

  public int getMaxConcurrentJobs() {
    return maxConcurrentJobs;
  }

  public void setMaxConcurrentJobs(final int maxConcurrentJobs) {
    this.maxConcurrentJobs = maxConcurrentJobs;
  }

  @Override
  public int hashCode() {
    final int prime = 31;
    int result = 1;
    result = prime * result + id;
    return result;
  }

  @Override
  public boolean equals(final Object obj) {
    return obj != null && this.getClass() == obj.getClass() && id == ((ScenarioUser) obj).id;
  }

}
