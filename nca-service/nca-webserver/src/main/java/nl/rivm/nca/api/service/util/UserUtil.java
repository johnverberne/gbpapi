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

import nl.rivm.nca.db.user.UserRepository;
import nl.rivm.nca.shared.domain.user.ScenarioUser;
import nl.rivm.nca.shared.exception.AeriusException;
import nl.rivm.nca.shared.exception.AeriusException.Reason;
import nl.rivm.nca.util.UuidUtil;

/**
 * User util class to help with user specific stuff.
 */
public final class UserUtil {

  public static ScenarioUser generateAPIKey(final Connection con, final String email) throws SQLException, AeriusException {
    ScenarioUser user = UserRepository.getUserByEmailAddress(con, email);    
    if (user == null) {
      user = createUser(con, email);
    } else {
      user = resetAPIKey(con, user);
    }
    return user;
  }
  
  /**
   * Fetch the user with given API key. Will also validate the maximum concurrent jobs.
   * @param con The database connection.
   * @param apiKey The API key of the user.
   * @return The user with the matching API key
   * @throws SQLException On DB errors.
   * @throws AeriusException Thrown if user not found, account is disabled or the max concurrent jobs is reached.
   */
  public static ScenarioUser getUser(final Connection con, final String apiKey)
      throws SQLException, AeriusException {
    return getUser(con, apiKey, true);
  }

  /**
   * Fetch the user with given API key.
   * @param con The database connection.
   * @param apiKey The API key of the user.
   * @param validateMaximumConcurrentJobs Whether to validate the maximum concurrent jobs.
   * @return The user with the matching API key
   * @throws SQLException On DB errors.
   * @throws AeriusException Thrown if user not found, account is disabled or if validateMaximumConcurrentJobs is true and the max is reached.
   */
  public static ScenarioUser getUser(final Connection con, final String apiKey, final boolean validateMaximumConcurrentJobs)
      throws SQLException, AeriusException {
    final ScenarioUser user = UserRepository.getUserByApiKey(con, apiKey);

    if (user == null) {
      throw new AeriusException(Reason.USER_INVALID_API_KEY, apiKey);
    }

    if (!user.isEnabled()) {
      throw new AeriusException(Reason.USER_ACCOUNT_DISABLED);
    }

    return user;
  }

  /**
   * Create a new user.
   *
   * @param pmf The PMF.
   * @param email The email address for the user.
   * @return User created.
   * @throws AeriusConnectException throws exception in case of validation errors.
   * @throws SQLException database error.
 * @throws AeriusException 
   */
  private static ScenarioUser createUser(final Connection con, final String email) throws SQLException, AeriusException {
    ScenarioUser user = null; //ScenarioUserRepository.getUserByEmailAddress(con, email);

    if (user == null) {
      final ScenarioUser createUser = new ScenarioUser();
      createUser.setApiKey(generateAPIKeyString());
      createUser.setEmailAddress(email);
      createUser.setEnabled(true);

      UserRepository.createUser(con, createUser);
      user = UserRepository.getUserByEmailAddress(con, email);
    }

    return user;
  }

  /**
   * Reset the API key of an existing user.
   *
   * @param con The database connection.
   * @param user user object.
   * @return
   * @throws SQLException database error.
   */
  private static ScenarioUser resetAPIKey(final Connection con, final ScenarioUser user) throws SQLException {
    user.setApiKey(generateAPIKeyString());
    UserRepository.updateUser(con, user);

    return UserRepository.getUserByEmailAddress(con, user.getEmailAddress());
  }

  private static String generateAPIKeyString() {
    return UuidUtil.getStripped();
  }

}