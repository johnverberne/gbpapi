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

public enum JobType {

  CALCULATION,
  REPORT,
  PRIORITY_PROJECT_UTILISATION;

  /**
   * Returns the name in lowercase.
   * @return name in lowercase
   */
  @Override
  public String toString() {
    return name().toLowerCase();
  }

  /**
   * Return the safe value from a type string, or null if it could not be matched.
   * @param value Type string to get the enum value of.
   * @return null if the type does not match, or the corresponding {@link JobType}.
   */
  public static JobType safeValueOf(final String value) {
    try {
      return value == null ? null : valueOf(value.toUpperCase());
    } catch (final IllegalArgumentException e) {
      return null;
    }
  }

}
