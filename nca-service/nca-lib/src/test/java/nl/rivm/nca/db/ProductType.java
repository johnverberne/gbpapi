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
package nl.rivm.nca.db;

/**
 * Contains the various products used.
 */
public enum ProductType {
  GBP;

  public String getDbRepresentation() {
    return name().toLowerCase();
  }

  /**
   * @param productName The product name to determine the product type for.
   * @return The right producttype (or null if none could be determined).
   */
  public static ProductType determineProductType(final String productName) {
    ProductType rightType = null;
    if (productName != null) {
      for (final ProductType type : ProductType.values()) {
        if (type.name().equals(productName.toUpperCase())) {
          rightType = type;
        }
      }
    }
    return rightType;
  }

  public String getLayerName(final String layer) {
    return name().toLowerCase() + ":" + layer;
  }

  public String getReportLayerName(final String layer) {
    return name().toLowerCase() + "_report:" + layer;
  }
}
