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
package nl.rivm.nca.db.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import nl.rivm.nca.db.util.Attribute;
import nl.rivm.nca.db.util.Attributes;
import nl.rivm.nca.db.util.InsertBuilder;
import nl.rivm.nca.db.util.InsertClause;
import nl.rivm.nca.db.util.Query;
import nl.rivm.nca.db.util.QueryAttribute;
import nl.rivm.nca.db.util.QueryBuilder;
import nl.rivm.nca.db.util.QueryUtil;
import nl.rivm.nca.shared.domain.JobProgress;
import nl.rivm.nca.shared.domain.JobType;
import nl.rivm.nca.shared.domain.ScenarioUser;



public final class JobRepository {

  protected enum RepositoryAttribute implements Attribute {
    JOB_ID,
    TYPE,
    STATE,
    HEXAGON_COUNTER,
    PICK_UP_TIME,
    START_TIME,
    END_TIME,
    ERROR_MESSAGE,
    RESULT_URL;

    @Override
    public String attribute() {
      return name().toLowerCase();
    }
  }

  private static final Logger LOGGER = LoggerFactory.getLogger(JobRepository.class);

  private static final String TABLE_JOBS = "jobs";
  private static final String TABLE_JOB_CALCULATIONS = "job_calculations";
  private static final String TABLE_JOB_PROGRESS = "job_progress";
  private static final String VIEW_JOB_PROGRESS = "job_progress_view";

  private static final Attributes FIELDS_JOB_PROGRESS = new Attributes(
      RepositoryAttribute.TYPE,
      RepositoryAttribute.STATE,
      RepositoryAttribute.HEXAGON_COUNTER,
      RepositoryAttribute.PICK_UP_TIME,
      RepositoryAttribute.START_TIME,
      RepositoryAttribute.END_TIME,
      RepositoryAttribute.RESULT_URL,
      RepositoryAttribute.ERROR_MESSAGE,
      QueryAttribute.KEY,
      QueryAttribute.NAME);

  private static final Query QUERY_CREATE_JOB =
      InsertBuilder.into(TABLE_JOBS)
          .insert(QueryAttribute.KEY)
          .insert(QueryAttribute.USER_ID)
          .insert(new InsertClause(RepositoryAttribute.TYPE.attribute(), "?::job_type", RepositoryAttribute.TYPE))
          .getQuery();
  private static final Query QUERY_INIT_JOB_PROGRESS =
      InsertBuilder.into(TABLE_JOB_PROGRESS)
          .insert(RepositoryAttribute.JOB_ID)
          .getQuery();
  private static final Query QUERY_ADD_JOB_CALCULATIONS =
      InsertBuilder.into(TABLE_JOB_CALCULATIONS)
          .insert(RepositoryAttribute.JOB_ID, QueryAttribute.CALCULATION_ID)
          .getQuery();
  private static final Query QUERY_GET_JOB_ID =
      QueryBuilder.from(TABLE_JOBS)
          .select(RepositoryAttribute.JOB_ID)
          .where(QueryAttribute.KEY)
          .getQuery();
  private static final Query QUERY_GET_JOB_PROGRESS =
      QueryBuilder.from(VIEW_JOB_PROGRESS)
          .select(RepositoryAttribute.JOB_ID)
          .select(FIELDS_JOB_PROGRESS)
          .where(RepositoryAttribute.JOB_ID)
          .getQuery();
  private static final Query QUERY_GET_JOB_PROGRESS_FOR_USER =
      QueryBuilder.from(VIEW_JOB_PROGRESS)
          .select(RepositoryAttribute.JOB_ID)
          .select(FIELDS_JOB_PROGRESS)
          .where(QueryAttribute.USER_ID)
          .orderBy(RepositoryAttribute.JOB_ID)
          .getQuery();
  private static final Query QUERY_GET_JOB_FOR_USER =
      QueryBuilder.from(TABLE_JOBS)
          .select(RepositoryAttribute.JOB_ID)
          .where(QueryAttribute.USER_ID, QueryAttribute.KEY)
          .getQuery();

  private static final String QUERY_DONE_JOBS_WITH_MIN_AGE =
      "SELECT job_id"
      + " FROM " + VIEW_JOB_PROGRESS
      + " INNER JOIN job_calculations USING (job_id)"
      + " WHERE state in ('cancelled', 'completed')"
      + "   AND (end_time <= now() - (interval '1 day' * ?)"
      + "        OR (end_time IS NULL AND start_time <= now() - (interval '1 day' * ?)))";
  private static final String QUERY_DELETE_JOB = "SELECT ae_delete_job(?)";
  private static final String QUERY_DELETE_JOB_CALCULATIONS =
      "SELECT ae_delete_job_calculations(job_id) FROM " + TABLE_JOBS
      + " WHERE " + TABLE_JOBS + ".key = ?";

  private static final String SQL_UPDATE_JOB_STATE_FIELD =
      "UPDATE " + TABLE_JOBS
          + " SET state = ?::job_state_type WHERE key = ? ";
  private static final String SQL_UPDATE_FIELD =
      "UPDATE " + TABLE_JOB_PROGRESS + " SET %s = ? FROM " + TABLE_JOBS
          + " WHERE " + TABLE_JOBS + ".job_id = " + TABLE_JOB_PROGRESS + ".job_id"
          + " AND " + TABLE_JOBS + ".key = ?";
  private static final String SQL_INCREMENT_FIELD =
      "UPDATE " + TABLE_JOB_PROGRESS + " SET %1$s = %1$s + ? FROM " + TABLE_JOBS
          + " WHERE " + TABLE_JOBS + ".job_id = " + TABLE_JOB_PROGRESS + ".job_id"
          + " AND " + TABLE_JOBS + ".key = ?";
  private static final String SQL_UPDATE_NAME =
      "UPDATE " + TABLE_JOBS + " SET name = ? "
          + " WHERE key = ?";
  private static final String SQL_UPDATE_ERROR_MESSAGE =
      "UPDATE " + TABLE_JOBS + " SET error_message = ? "
          + " WHERE key = ?";

  private JobRepository() {
    // Not allowed to instantiate.
  }

  /**
   * Create job for user.
   * @param con The connection to use.
   * @param user The user to create job for.
   * @param type The type of job to create.
   * @param correlationId The correlationId to use as key.
   * @throws SQLException Database errors.
   */
//  public static int createJob(final Connection con, final ScenarioUser user, final JobType type, final String correlationId) throws SQLException {
//    return createJob(con, user, type, correlationId, null);
//  }

  /**
   * Create job for user.
   * @param con The connection to use.
   * @param user The user to create job for.
   * @param type The type of job to create.
   * @param correlationId The correlationId to use as key.
   * @param name Optional name of the job.
   * @throws SQLException Database errors.
   */
//  public static int createJob(final Connection con, final ScenarioUser user, final JobType type, final String correlationId, final String name)
//      throws SQLException {
//    final int jobId = insertJob(con, user, correlationId, type);
//    setStartTimeToNow(con, correlationId);
//
//    if (StringUtils.isNotEmpty(name)) {
//      setName(con, correlationId, name);
//    }
//
//    return jobId;
//  }

//  /**
//   * Associate calculation id's to a job.
//   */
//  public static void attachCalculations(final Connection con, final String correlationId, final Iterable<Integer> calculationIds)
//      throws SQLException {
//    final int jobId = getJobId(con, correlationId);
//
//    try (final PreparedStatement ps = con.prepareStatement(QUERY_ADD_JOB_CALCULATIONS.get())) {
//      QUERY_ADD_JOB_CALCULATIONS.setParameter(ps, RepositoryAttribute.JOB_ID, jobId);
//      for (final Integer calculationId : calculationIds) {
//        QUERY_ADD_JOB_CALCULATIONS.setParameter(ps, QueryAttribute.CALCULATION_ID, calculationId);
//        ps.addBatch();
//      }
//      ps.executeBatch();
//
//      // update jobState and pickup time
//      updateJobStatus(con, correlationId, JobState.RUNNING);
//      setPickUpTimeToNow(con, correlationId);
//
//    } catch (final SQLException e) {
//      LOG.error("Error attaching calculations to job {}", jobId, e);
//      throw e;
//    }
//  }
//
//  /**
//   * Get the job id that belongs to a certain correlation identifier.
//   * Returns 0 when no job is found for that identifier.
//   */
//  public static int getJobId(final Connection con, final String correlationId) throws SQLException {
//    int jobId = 0;
//    try (final PreparedStatement stmt = con.prepareStatement(QUERY_GET_JOB_ID.get())) {
//      QUERY_GET_JOB_ID.setParameter(stmt, QueryAttribute.KEY, correlationId);
//      final ResultSet rs = stmt.executeQuery();
//      if (rs.next()) {
//        jobId = QueryUtil.getInt(rs, RepositoryAttribute.JOB_ID);
//      }
//    }
//    return jobId;
//  }
//
//  /**
//   * Fetch the job progress from the database using the correlation id as lookup.
//   * Returns null when no progress record is found for that id.
//   */
//  public static JobProgress getProgress(final Connection con, final String correlationId) throws SQLException {
//    JobProgress jobProgress = null;
//    final int jobId = getJobId(con, correlationId);
//    if (jobId > 0) {
//      try (final PreparedStatement stmt = con.prepareStatement(QUERY_GET_JOB_PROGRESS.get())) {
//        QUERY_GET_JOB_PROGRESS.setParameter(stmt, RepositoryAttribute.JOB_ID, jobId);
//        final ResultSet rs = stmt.executeQuery();
//        if (rs.next()) {
//          jobProgress = new JobProgress();
//          fillJobProgress(jobProgress, rs);
//        }
//      }
//    }
//    return jobProgress;
//  }
//
  /**
   * Fetches job progress objects for all jobs of the given user.
   */
  public static List<JobProgress> getProgressForUser(final Connection con, final ScenarioUser user) throws SQLException {
    final List<JobProgress> progresses = new ArrayList<>();
    try (final PreparedStatement stmt = con.prepareStatement(QUERY_GET_JOB_PROGRESS_FOR_USER.get())) {
      QUERY_GET_JOB_PROGRESS_FOR_USER.setParameter(stmt, QueryAttribute.USER_ID, user.getId());
      final ResultSet rs = stmt.executeQuery();
      while (rs.next()) {
        final JobProgress jobProgress = new JobProgress();
        fillJobProgress(jobProgress, rs);
        progresses.add(jobProgress);
      }
    }
    return progresses;
  }
  
//
//  /**
//   * Remove job fully. This includes calculations/progress and such.
//   * @param con The connection to use.
//   * @param jobId The job ID of the job to remove.
//   * @return If a job is removed.
//   */
//  public static boolean removeJob(final Connection con, final int jobId) {
//    try (final PreparedStatement stmt = con.prepareStatement(QUERY_DELETE_JOB)) {
//      QueryUtil.setValues(stmt, jobId);
//      stmt.execute();
//    } catch (final SQLException e) {
//      LOG.error("Error removing job {}", jobId, e);
//      return false;
//    }
//
//    return true;
//  }
//
//  /**
//   * Remove only the calculations of a job.
//   * @param con The connection to use.
//   * @param correlationId The job key of the job to remove the calculations from.
//   * @return If a calculations are removed.
//   */
//  public static boolean removeJobCalculations(final Connection con, final String correlationId) {
//    try (final PreparedStatement stmt = con.prepareStatement(QUERY_DELETE_JOB_CALCULATIONS)) {
//      QueryUtil.setValues(stmt, correlationId);
//      stmt.execute();
//    } catch (final SQLException e) {
//      LOG.error("Error removing job with key {}", correlationId, e);
//      return false;
//    }
//
//    return true;
//  }
//
//  /**
//   * Remove jobs that are finished ('completed' or 'cancelled') with the age given.
//   * The age is computed based on the time of completion (endTime).
//   * In case there is no endTime present (because of a bug or something else that is wrong)
//   *  the age is computed based on the time of job creation (startTime).
//   * @param con The connection to use.
//   * @param ageInDays The age in days to use.
//   * @return amount of jobs removed.
//   * @throws SQLException In case of a database error.
//   */
//  public static int removeJobsWithMinAge(final Connection con, final int ageInDays) throws SQLException {
//    int amountRemoved = 0;
//    try (final PreparedStatement stmt = con.prepareStatement(QUERY_DONE_JOBS_WITH_MIN_AGE)) {
//      QueryUtil.setValues(stmt, ageInDays, ageInDays);
//      final ResultSet rs = stmt.executeQuery();
//      while (rs.next()) {
//        if (removeJob(con, QueryUtil.getInt(rs, RepositoryAttribute.JOB_ID))) {
//          amountRemoved++;
//        }
//      }
//    } catch (final SQLException e) {
//      LOG.error("Fetching jobs to remove failed. Hard.", e);
//    }
//
//    return amountRemoved;
//  }
//
//  /**
//   * Increase the hexagon counter of the given job with the given increment.
//   * @param correlationId An identifier used by the worker to associate itself with this job.
//   * @throws SQLException In case of a database error.
//   */
//  public static void increaseHexagonCounter(final Connection con, final String correlationId, final long increment) throws SQLException {
//    incrementField(con, correlationId, RepositoryAttribute.HEXAGON_COUNTER, increment);
//  }
//
//  /**
//   * Set the end time of the given job to the the current time.
//   */
//  public static void setEndTimeToNow(final Connection con, final String correlationId) throws SQLException {
//    updateField(con, correlationId, RepositoryAttribute.END_TIME, new Timestamp(new Date().getTime()));
//  }
//
//  /**
//   * Set the end time of the given job to the the current time.
//   */
//  public static void setPickUpTimeToNow(final Connection con, final String correlationId) throws SQLException {
//    updateField(con, correlationId, RepositoryAttribute.PICK_UP_TIME, new Timestamp(new Date().getTime()));
//  }
//
//  /**
//   * Set the jobState for the job.
//   */
//  public static void updateJobStatus(final Connection con, final String correlationId, final JobState state) throws SQLException {
//    try (final PreparedStatement updatePS = con.prepareStatement(SQL_UPDATE_JOB_STATE_FIELD)) {
//      QueryUtil.setValues(updatePS, state.toDatabaseString(), correlationId);
//      updatePS.executeUpdate();
//    }
//  }
//
//  /**
//   * Set the result url of the given job.
//   */
//  public static void setResultUrl(final Connection con, final String correlationId, final String resultUrl) throws SQLException {
//    updateField(con, correlationId, RepositoryAttribute.RESULT_URL, resultUrl);
//  }
//
//  /**
//   * Set the error message text if Job is stopped with a error and change jobState to ERROR.
//   */
//  public static void setErrorMessage(final Connection con, final String correlationId, final String message) throws SQLException {
//    updateJobStatus(con, correlationId, JobState.ERROR);
//    try (final PreparedStatement ps = con.prepareStatement(SQL_UPDATE_ERROR_MESSAGE)) {
//      QueryUtil.setValues(ps, message, correlationId);
//      ps.executeUpdate();
//    }
//  }
//
//  /**
//   * Returns if a given user and jobKey exist.
//   * @param con database connection.
//   * @param user the user object.
//   * @param jobKey the jobKey.
//   * @return true if the combination is found.
//   * @throws SQLException
//   */
//  public static boolean isJobFromUser(final Connection con, final ScenarioUser user, final String jobKey) throws SQLException {
//    try (final PreparedStatement stmt = con.prepareStatement(QUERY_GET_JOB_FOR_USER.get())) {
//      QUERY_GET_JOB_FOR_USER.setParameter(stmt, QueryAttribute.USER_ID, user.getId());
//      QUERY_GET_JOB_FOR_USER.setParameter(stmt, QueryAttribute.KEY, jobKey);
//      final ResultSet rs = stmt.executeQuery();
//      return rs.next();
//    }
//  }
//
//  /**
//   * Set the name of the given job.
//   */
//  private static void setName(final Connection con, final String correlationId, final String name) throws SQLException {
//    try (final PreparedStatement ps = con.prepareStatement(SQL_UPDATE_NAME)) {
//      QueryUtil.setValues(ps, name, correlationId);
//      ps.executeUpdate();
//    }
//  }
//
//  /**
//   * Set the start time of the given job to the the current time.
//   */
//  private static void setStartTimeToNow(final Connection con, final String correlationId) throws SQLException {
//    updateField(con, correlationId, RepositoryAttribute.START_TIME, new Timestamp(new Date().getTime()));
//  }
//
//  /**
//   * Insert an empty job for the given user.
//   *
//   * @param con The connection to use.
//   * @param user The user to create the job for.
//   * @param jobType The job type.
//   * @param correlationId An identifier used by the worker to associate itself with this job.
//   * @throws SQLException In case of a database error.
//   */
//  private static int insertJob(final Connection con, final ScenarioUser user, final String correlationId, final JobType jobType) throws SQLException {
//    try (final PreparedStatement psCreate = con.prepareStatement(QUERY_CREATE_JOB.get(), Statement.RETURN_GENERATED_KEYS)) {
//      QUERY_CREATE_JOB.setParameter(psCreate, QueryAttribute.KEY, correlationId);
//      QUERY_CREATE_JOB.setParameter(psCreate, QueryAttribute.USER_ID, user.getId());
//      QUERY_CREATE_JOB.setParameter(psCreate, RepositoryAttribute.TYPE, jobType.toString());
//
//      psCreate.executeUpdate();
//      final ResultSet rs = psCreate.getGeneratedKeys();
//      rs.next();
//      final int jobId = rs.getInt(1);
//
//      // Initialize job in the job progress table with 0 and NULL values.
//      try (final PreparedStatement psInit = con.prepareStatement(QUERY_INIT_JOB_PROGRESS.get())) {
//        QUERY_INIT_JOB_PROGRESS.setParameter(psInit, RepositoryAttribute.JOB_ID, jobId);
//        psInit.executeUpdate();
//      }
//
//      return jobId;
//
//    } catch (final SQLException e) {
//      LOG.error("Error creating job for user {}", user.getEmailAddress(), e);
//      throw e;
//    }
//  }
//
//  static <T> void updateField(final Connection con, final String correlationId, final Attribute attribute, final T value)
//      throws SQLException {
//    final String sql = String.format(SQL_UPDATE_FIELD, attribute.attribute());
//    try (final PreparedStatement ps = con.prepareStatement(sql)) {
//      QueryUtil.setValues(ps, value, correlationId);
//      ps.executeUpdate();
//    }
//  }
//
  private static void fillJobProgress(final JobProgress jobProgress, final ResultSet rs) throws SQLException {
    jobProgress.setType(QueryUtil.getEnum(rs, RepositoryAttribute.TYPE, JobType.class));
    jobProgress.setKey(QueryUtil.getString(rs, QueryAttribute.KEY));
    jobProgress.setName(QueryUtil.getString(rs, QueryAttribute.NAME));
    jobProgress.setState(QueryUtil.getEnum(rs, RepositoryAttribute.STATE, nl.rivm.nca.shared.domain.JobProgress.JobState.class));
    jobProgress.setHexagonCount(QueryUtil.getLong(rs, RepositoryAttribute.HEXAGON_COUNTER));
    jobProgress.setCreationDateTime(QueryUtil.getDate(rs, RepositoryAttribute.PICK_UP_TIME));
    jobProgress.setStartDateTime(QueryUtil.getDate(rs, RepositoryAttribute.START_TIME));
    jobProgress.setEndDateTime(QueryUtil.getDate(rs, RepositoryAttribute.END_TIME));
    jobProgress.setResultUrl(QueryUtil.getString(rs, RepositoryAttribute.RESULT_URL));
  }
//
//  private static <T> void incrementField(final Connection con, final String correlationId, final Attribute attribute, final T value)
//      throws SQLException {
//    final String sql = String.format(SQL_INCREMENT_FIELD, attribute.attribute());
//    try (final PreparedStatement ps = con.prepareStatement(sql)) {
//      QueryUtil.setValues(ps, value, correlationId);
//      ps.executeUpdate();
//    }
//  }


}
