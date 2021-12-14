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
package nl.rivm.nca.shared.domain.measure;

import java.io.Serializable;

/**
 * Data object of a measures.
 */
public class ModelMeasure implements Serializable {

  private static final long serialVersionUID = 158544847778890161L;

  private int id;
  private String key;
  private String ApiKey;
  private int user_id;
  private boolean enabled = true;
  private boolean validated = true;
  private String name;
  private String version;
  private String measures;

  public int getId() {
    return id;
  }

  public void setId(final int id) {
    this.id = id;
  }

  public boolean isEnabled() {
    return enabled;
  }

  public void setEnabled(final boolean enabled) {
    this.enabled = enabled;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getMeasures() {
    return measures;
  }

  public void setMeasures(String measures) {
    this.measures = measures;
  }

  public String getApiKey() {
    return ApiKey;
  }

  public void setApiKey(String apiKey) {
    ApiKey = apiKey;
  }

  public String getVersion() {
    return version;
  }

  public void setVersion(String version) {
    this.version = version;
  }

  public String getKey() {
    return key;
  }

  public void setKey(String key) {
    this.key = key;
  }

  public int getUser_id() {
    return user_id;
  }

  public void setUser_id(int user_id) {
    this.user_id = user_id;
  }

  public boolean isValidated() {
    return validated;
  }

  public void setValidated(boolean validated) {
    this.validated = validated;
  }

}
