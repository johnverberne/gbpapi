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
package nl.rivm.nca.db.measures;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.postgresql.util.PSQLException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.db.util.Attribute;
import nl.rivm.nca.db.util.Attributes;
import nl.rivm.nca.db.util.InsertBuilder;
import nl.rivm.nca.db.util.Query;
import nl.rivm.nca.db.util.QueryAttribute;
import nl.rivm.nca.db.util.QueryBuilder;
import nl.rivm.nca.db.util.QueryUtil;
import nl.rivm.nca.shared.domain.measure.ModelMeasure;
import nl.rivm.nca.shared.exception.AeriusException;
import nl.rivm.nca.shared.exception.AeriusException.Reason;

public final class MeasuresRepository {

	private enum RepositoryAttribute implements Attribute {
    KEY, USER_ID, NAME, VERSION, ACTIVE, VALIDATED, MEASURES;
	  
    @Override
    public String attribute() {
      return name().toLowerCase();
    }
  }
	
	private static final Logger LOG = LoggerFactory.getLogger(MeasuresRepository.class);
	
	private static final String DELETE_MEASURES_BY_KEY = "DELETE FROM measures WHERE measures.KEY = ?";
	  
	private static final Attributes FIELDS_MEASURES = new Attributes(RepositoryAttribute.KEY, RepositoryAttribute.USER_ID,
	  RepositoryAttribute.NAME, RepositoryAttribute.VERSION, RepositoryAttribute.ACTIVE, RepositoryAttribute.VALIDATED, 
	  RepositoryAttribute.MEASURES);

	private static final String TABLE_MEASURES = "measures";

  private static final Query QUERY_CREATE_MEASURE = InsertBuilder.into(TABLE_MEASURES).insert(FIELDS_MEASURES).getQuery();

  private static final Query QUERY_GET_ALL_MEASURES_BY_USER = getMeasursQueryBuilder().where(RepositoryAttribute.USER_ID)
      .where(RepositoryAttribute.ACTIVE).getQuery();
  
  private static final Query QUERY_GET_MEASURES_BY_USER = getMeasursQueryBuilder().where(RepositoryAttribute.USER_ID)
      .where(RepositoryAttribute.KEY).where(RepositoryAttribute.ACTIVE).getQuery();

	private MeasuresRepository() {
		// Not allowed to instantiate.
	}

	/**
	 * Create measure data for user and query the data
	 *
	 * @param con
	 *            The connection to use.
	 * @param measure
	 *            The user to create (id is ignored / max concurrent jobs is
	 *            automatically filled).
	 * @throws SQLException
	 *             In case of a database error.
	 * @throws AeriusException
	 *             When the user already exists.
	 */
	public static int createMeasure(final Connection con, final ModelMeasure measure) throws SQLException, AeriusException {

		try (final PreparedStatement ps = con.prepareStatement(QUERY_CREATE_MEASURE.get(),Statement.RETURN_GENERATED_KEYS)) {
		  QUERY_CREATE_MEASURE.setParameter(ps, RepositoryAttribute.KEY, measure.getKey());
			QUERY_CREATE_MEASURE.setParameter(ps, RepositoryAttribute.USER_ID, measure.getUser_id());
			QUERY_CREATE_MEASURE.setParameter(ps, RepositoryAttribute.NAME, measure.getName());
			QUERY_CREATE_MEASURE.setParameter(ps, RepositoryAttribute.VERSION, measure.getVersion());
			QUERY_CREATE_MEASURE.setParameter(ps, RepositoryAttribute.MEASURES, measure.getMeasures()); 
      QUERY_CREATE_MEASURE.setParameter(ps, RepositoryAttribute.ACTIVE, measure.isEnabled()); 
      QUERY_CREATE_MEASURE.setParameter(ps, RepositoryAttribute.VALIDATED, measure.isValidated()); 

			ps.executeUpdate();
			final ResultSet rs = ps.getGeneratedKeys();
			if (rs.next()) {
				return rs.getInt(1);
			} else {
				throw new AeriusException(Reason.INTERNAL_ERROR, measure.getApiKey());
			}
		} catch (final PSQLException e) {
		  throw e;
		}
	}
	
	 /**
   * Fetch a list of modelMeasure for given api key and measureKey.
   * Returns null when the measures is not found.
   */ 
  public static List<ModelMeasure> getAllMeasuresByUser(final Connection con, final int user_id) throws SQLException {
    final List<ModelMeasure> measures = new ArrayList<>();
    try (final PreparedStatement stmt = con.prepareStatement(QUERY_GET_ALL_MEASURES_BY_USER.get())) {
      QUERY_GET_ALL_MEASURES_BY_USER.setParameter(stmt, RepositoryAttribute.USER_ID, user_id);
      QUERY_GET_ALL_MEASURES_BY_USER.setParameter(stmt, RepositoryAttribute.ACTIVE, true);
      final ResultSet rs = stmt.executeQuery();
      while (rs.next()) {        
        final ModelMeasure measure = new ModelMeasure();
        fillMeasure(measure, rs);
        measures.add(measure);
      }
    }
    return measures;
  }

	/**
	 * Fetch a Json String with for given api key and measureKey.
	 * Returns null when the measures is not found.
	 */	
	public static String getMeasuresByUser(final Connection con, final int user_id, final String measureKey) throws SQLException {
	  final ModelMeasure measure = new ModelMeasure();
    try (final PreparedStatement stmt = con.prepareStatement(QUERY_GET_MEASURES_BY_USER.get())) {
      QUERY_GET_MEASURES_BY_USER.setParameter(stmt, RepositoryAttribute.USER_ID, user_id);
      QUERY_GET_MEASURES_BY_USER.setParameter(stmt, RepositoryAttribute.KEY, measureKey);
      QUERY_GET_MEASURES_BY_USER.setParameter(stmt, RepositoryAttribute.ACTIVE, true);
      final ResultSet rs = stmt.executeQuery();
      while (rs.next()) {        
        fillMeasure(measure, rs);
      }
    }
    return measure.getMeasures();
  }
	
  public static boolean removeMeasure(final Connection con, final String measureKey) {
      try (final PreparedStatement updatePS = con.prepareStatement(DELETE_MEASURES_BY_KEY)) {
        QueryUtil.setValues(updatePS, measureKey);
        updatePS.execute();
        return true;
      } catch (SQLException e) {
        LOG.error("Error removing job {}", measureKey, e);
        return false;
      }          
  }
	
	private static void fillMeasure(final ModelMeasure measure, final ResultSet rs) throws SQLException {
		measure.setKey(QueryUtil.getString(rs, RepositoryAttribute.KEY));
		measure.setVersion(QueryUtil.getString(rs, RepositoryAttribute.VERSION));		
		measure.setName(QueryUtil.getString(rs, RepositoryAttribute.NAME));
		measure.setEnabled(QueryUtil.getBoolean(rs, RepositoryAttribute.ACTIVE));
    measure.setEnabled(QueryUtil.getBoolean(rs, RepositoryAttribute.VALIDATED));
		measure.setMeasures(QueryUtil.getString(rs, RepositoryAttribute.MEASURES));
	}
	
	private static QueryBuilder getMeasursQueryBuilder() {
		return QueryBuilder.from(TABLE_MEASURES).select(QueryAttribute.KEY).select(FIELDS_MEASURES);
	}
	
}
