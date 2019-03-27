package nl.rivm.nca.db.calculation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.postgresql.util.PGobject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import nl.rivm.nca.api.domain.AssessmentResultResponse;
import nl.rivm.nca.db.user.JobRepository;
import nl.rivm.nca.db.user.UserRepository;
import nl.rivm.nca.db.util.Attribute;
import nl.rivm.nca.db.util.Attributes;
import nl.rivm.nca.db.util.Query;
import nl.rivm.nca.db.util.QueryBuilder;
import nl.rivm.nca.db.util.QueryUtil;
import nl.rivm.nca.shared.domain.JobType;
import nl.rivm.nca.shared.domain.calculation.Calculation;
import nl.rivm.nca.shared.domain.calculation.CalculationResult;
import nl.rivm.nca.shared.domain.calculation.JobState;
import nl.rivm.nca.shared.domain.user.ScenarioUser;

public class CalculationRepository {
	
	
	
	public enum QueryAttribute implements Attribute {
		CALCULATION_ID;

		@Override
		public String attribute() {
			return name().toLowerCase();
		}
	}

	protected enum RepositoryAttribute implements Attribute {
		CALCULATION_ID, MODEL, GEOLAYER, DATA, PICK_UP_TIME, START_TIME, END_TIME, ERROR_MESSAGE;

		@Override
		public String attribute() {
			return name().toLowerCase();
		}
	}

	// The logger.
	private static final Logger LOG = LoggerFactory.getLogger(CalculationRepository.class);

	private static final String VIEW_CALCULATION_RESULT = "calculation_results"; //create a view
	  private static final Attributes FIELDS_CALCULATION_RESULT = new Attributes(
		      RepositoryAttribute.CALCULATION_ID,
		      RepositoryAttribute.MODEL,
		      RepositoryAttribute.GEOLAYER,
		      RepositoryAttribute.DATA);
	
	// SQL queries for calculation(s)
	private static final String GET_CALCULATION = "SELECT calculation_id, creation_time, state "
			+ " FROM calculations WHERE calculation_id = ? ";
	private static final String INSERT_CALCULATION = "INSERT INTO calculations (calculation_uuid) VALUES (?)";
	private static final String INSERT_CALCULATION_RESULT = "INSERT INTO calculation_results (calculation_id, model, geolayer, data) VALUES (?,?,?,?)";
	private static final String GET_CALCULATION_RESULTS = "SELECT * FROM calculation_results WHERE calculation_id = ?";
	private static final Query QUERY_GET_CALCULATION_RESULTS_FOR_CALCULATION = QueryBuilder
			.from(VIEW_CALCULATION_RESULT).select(RepositoryAttribute.CALCULATION_ID).select(FIELDS_CALCULATION_RESULT)
			.where(QueryAttribute.CALCULATION_ID).orderBy(RepositoryAttribute.CALCULATION_ID).getQuery();

	private CalculationRepository() {
	};

	/**
	 * @param connection
	 *            The connection to use.
	 * @param calculation
	 *            the calculation object to persist to the database and fill
	 *            with some extra information.
	 * @param calculationPointSetId
	 *            The calculation point set ID that the calculation will use.
	 * @return The filled calculation.
	 * @throws SQLException
	 *             If an error occurred communicating with the DB.
	 */
	public static Calculation insertCalculation(final Connection connection, final Calculation calculation,
			final String uuid) throws SQLException {
		// ensure a calculation has a set it belongs to, even if it's the only
		// one.
		try (final PreparedStatement insertPS = connection.prepareStatement(INSERT_CALCULATION,
				Statement.RETURN_GENERATED_KEYS)) {
			insertPS.setString(1, uuid);
			insertPS.executeUpdate();
			try (final ResultSet rs = insertPS.getGeneratedKeys()) {
				if (rs.next()) {
					calculation.setCalculationId(rs.getInt(1));
				} else {
					throw new SQLException("No generated key obtained while saving new calculation.");
				}
			}
		}
		return getCalculation(connection, calculation.getCalculationId());
	}

	/**
	 * @param connection
	 *            The connection to use
	 * @param calculationId
	 *            The id of the calculation trying to retrieve
	 * @return The calculation object, null if not found. Calculation options
	 *         (if existing) are NOT set. (use getCalculationOptions to get
	 *         those.)
	 * @throws SQLException
	 *             If an error occurred communicating with the DB.
	 */
	public static Calculation getCalculation(final Connection connection, final int calculationId) throws SQLException {
		final Calculation calculation = new Calculation();
		calculation.setCalculationId(calculationId);
		return getCalculation(connection, calculation);
	}

	private static Calculation getCalculation(final Connection connection, final Calculation calculation)
			throws SQLException {
		final Calculation foundCalculation;
		try (final PreparedStatement selectPS = connection.prepareStatement(GET_CALCULATION)) {
			selectPS.setLong(1, calculation.getCalculationId());
			try (final ResultSet rs = selectPS.executeQuery()) {
				if (rs.next()) {
					calculation.setCalculationId(rs.getInt("calculation_id"));
					calculation.setCreationDate(rs.getTimestamp("creation_time"));
					foundCalculation = calculation;
				} else {
					foundCalculation = null;
				}
			}
		}
		return foundCalculation;
	}

	/**
	 * 
	 * @param gbpConnection
	 * @param calculationId
	 * @param string
	 *            json string
	 * @return
	 * @throws SQLException
	 */
	public static int insertCalculationResult(Connection connection, int calculationId, String model,
			String geolayerUrl, String jsonString) throws SQLException {
		// ensure a calculation has a set it belongs to, even if it's the only
		// one.
		int id;
		try (final PreparedStatement insertPS = connection.prepareStatement(INSERT_CALCULATION_RESULT,
				Statement.RETURN_GENERATED_KEYS)) {
			insertPS.setInt(1, calculationId);
			insertPS.setString(2, model);
			insertPS.setString(3, geolayerUrl);
			PGobject jsonObject = new PGobject();
			jsonObject.setType("json");
			jsonObject.setValue(jsonString);
			insertPS.setObject(4, null, Types.OTHER);
			insertPS.executeUpdate();
			try (final ResultSet rs = insertPS.getGeneratedKeys()) {
				if (rs.next()) {
					id = rs.getInt(1);
				} else {
					throw new SQLException("No generated key obtained while saving new calculation result.");
				}
			}
		}
		return id;
	}

	/**
	 * 
	 * @param connection
	 * @param uuid
	 * @return
	 * @throws SQLException
	 */
	public static List<CalculationResult> getCalculationResult(Connection connection, int calculationId)
			throws SQLException {
		final List<CalculationResult> results = new ArrayList<>();

		try (final PreparedStatement stmt = connection
				.prepareStatement(QUERY_GET_CALCULATION_RESULTS_FOR_CALCULATION.get())) {
			QUERY_GET_CALCULATION_RESULTS_FOR_CALCULATION.setParameter(stmt, QueryAttribute.CALCULATION_ID,
					calculationId);

			final ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				final CalculationResult result = new CalculationResult();
				fillCalculationResult(result, rs);
				results.add(result);
			}
		}

		return results;
	}

	private static void fillCalculationResult(final CalculationResult result, final ResultSet rs) throws SQLException {
		result.setCalculationId(QueryUtil.getInt(rs, RepositoryAttribute.CALCULATION_ID));
		result.setModel(QueryUtil.getString(rs, RepositoryAttribute.MODEL));
		result.setGeolayer(QueryUtil.getString(rs, RepositoryAttribute.GEOLAYER));
		result.setData(QueryUtil.getString(rs, RepositoryAttribute.DATA));
	}

	/**
	 * 
	 * @param connection
	 * @param calculationId
	 * @param uuid 
	 * @param modelResults
	 * @throws SQLException
	 */
	public static void insertCalculationResults(Connection connection, int calculationId,
			String correlationId, List<AssessmentResultResponse> modelResults) throws SQLException {
		for (AssessmentResultResponse modelResult : modelResults) {
			insertCalculationResult(connection, calculationId, modelResult.getModel(), modelResult.getName(), modelResult.toString());
		}
		JobRepository.setEndTimeToNow(connection, correlationId);
		JobRepository.updateJobStatus(connection, correlationId, JobState.COMPLETED);
	}

	/**
	 * 
	 * @param connection
	 * @param newCalculation
	 * @param uuid
	 * @param user
	 * @param name 
	 * @return
	 * @throws SQLException
	 */
	public static Calculation insertCalculation(Connection connection, Calculation newCalculation, String uuid, ScenarioUser user, String name) throws SQLException {
		JobRepository.createJob(connection, user, JobType.CALCULATION, uuid, name);
		Calculation calculation = insertCalculation(connection, newCalculation, uuid);
		// if we run more than one scenario we will start different calculations for now only one
		 final Iterable<Integer> calculationIds = new ArrayList<Integer>(calculation.getCalculationId());
		JobRepository.attachCalculations(connection, uuid, calculationIds);
		return calculation;
	}

}
