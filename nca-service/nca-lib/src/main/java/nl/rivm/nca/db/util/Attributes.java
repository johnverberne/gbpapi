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
package nl.rivm.nca.db.util;

import java.util.Arrays;

/**
 * Safe wrapper around an array of attributes.
 */
public class Attributes {

  private final Attribute[] safeAttributes;

  public Attributes(final Attributes a, final Attributes b) {
    safeAttributes = Arrays.copyOf(a.get(), a.size() + b.size());
    System.arraycopy(b.get(), 0, safeAttributes, a.size(), b.size());
  }

  public Attributes(final Attribute... attributes) {
    this.safeAttributes = Arrays.copyOf(attributes, attributes.length);
  }

  private int size() {
    return safeAttributes.length;
  }

  public Attribute[] get() {
    return Arrays.copyOf(safeAttributes, safeAttributes.length);
  }

  public Attributes add(final Attributes attributes) {
    return new Attributes(this, attributes);
  }
}
