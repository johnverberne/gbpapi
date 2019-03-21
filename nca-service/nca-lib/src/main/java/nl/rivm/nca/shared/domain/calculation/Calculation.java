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

import java.io.Serializable;
import java.util.Date;

/**
 * The {@link Calculation} object contains all data for single calculation for a fixed set of input data consisting of:
 * year, substances and sources. Additional it contains the set of options that define the output.
 */
public class Calculation implements Serializable {

  private static final long serialVersionUID = -540535886143523135L;

  private int calculationId;
  private Date creationDate;


  public int getCalculationId() {
    return calculationId;
  }

  public void setCalculationId(final int calculationId) {
    this.calculationId = calculationId;
  }


  public Date getCreationDate() {
    return creationDate;
  }

  public void setCreationDate(final Date creationDate) {
    this.creationDate = creationDate;
  }


  @Override
  public String toString() {
    return "CalculationSet [calculationId=" + calculationId + ", creationDate=" + creationDate + "]";
  }
}
