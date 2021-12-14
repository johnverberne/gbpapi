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
package nl.rivm.nca.api.service.util;

import java.sql.Connection;
import java.sql.SQLException;

import nl.rivm.nca.db.measures.MeasuresRepository;
import nl.rivm.nca.shared.domain.user.ScenarioUser;
import nl.rivm.nca.shared.exception.AeriusException;
import nl.rivm.nca.shared.exception.AeriusException.Reason;

/**
 * MeasureUtil util class to help with measure specific stuff.
 */
public final class MeasureUtil {

  public static void validateMeasure(Connection con, ScenarioUser user, String measureKey) throws SQLException, AeriusException {
    String lookupMeasure = MeasuresRepository.getMeasuresByUser(con, user.getId(), measureKey.toUpperCase());
    if (lookupMeasure == null) {
      throw new AeriusException(Reason.CALCULATION_MEASURE_NAME_DOES_NOT_EXISTS, measureKey.toUpperCase());     
    }
  }

}