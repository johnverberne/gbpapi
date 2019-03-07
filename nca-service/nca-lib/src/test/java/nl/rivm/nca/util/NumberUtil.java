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
package nl.rivm.nca.util;

/**
 * Util class for number related methods.
 */
public final class NumberUtil {

  /**
   * Util
   */
  private NumberUtil() {
    // util
  }

  /**
   * Safely convert a float to a double without loosing precision.
   * @see http://stackoverflow.com/questions/916081
   * @param value float value
   * @return double value
   */
  public static double safeFloat2Double(final float value) {
    return Double.parseDouble(Float.toString(value));
  }
}
