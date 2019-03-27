/*
 * Copyright the State of the Netherlands
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
package nl.rivm.nca.shared.domain.calculation;

/**
 * States a Job can be in. The names are used in the database (lowercase), so take care when changing.
 */
public enum JobState {
  /**
   * State is undefined.
   */
  UNDEFINED,
  /**
   * Job initialized.
   */
  INITIALIZED,
  /**
   * Job running.
   */
  RUNNING,
  /**
   * Job cancelled.
   */
  CANCELLED,
  /**
   * Job is ended with a error.
   */
  ERROR,
  /**
   * Job completed.
   */
  COMPLETED;

  /**
   * Returns the name as represented in the database.
   * @return name as represented in the database
   */
  public Object toDatabaseString() {
    return name().toLowerCase();
  }
}
