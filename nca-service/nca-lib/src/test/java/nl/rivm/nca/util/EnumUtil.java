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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 */
public final class EnumUtil {

  private static final Logger LOG = LoggerFactory.getLogger(EnumUtil.class);

  private EnumUtil() {
    //util class
  }

  /**
   * Get an enum value from a String, without having to worry about IllegalArgumentExceptions.
   * Will return null if a null is supplied or the value isn't in the enum.
   * Value will be send to uppercase before being tested for, so be sure to have uppercase declarations in the enum when using this.
   *
   * @param enumClass The class to get the enum value for.
   * @param value The string representation of the enum.
   * @return The enum or null if not found.
   */
  public static <E extends Enum<E>> E get(final Class<E> enumClass, final String value) {
    E correctOne = null;
    if (value != null) {
      try {
        correctOne = Enum.valueOf(enumClass, value.toUpperCase());
      } catch (final IllegalArgumentException ex) {
        LOG.warn("Unknown value ({}) for enum type ({})", value, enumClass);
      }
    }
    return correctOne;
  }

}
