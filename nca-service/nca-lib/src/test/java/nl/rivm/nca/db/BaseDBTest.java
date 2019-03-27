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

import java.io.BufferedInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;



/**
 * Base class for Database tests. This class initializes the database connection
 * configuration in @Before state and closes the connection in @After.
 */
public class BaseDBTest {

  protected static ExecutorService EXECUTOR;

  private static final String TEST_DATABASE_PROPERTIES = "testdatabase.properties";
  private static final TestPMF GBP_PMF = new TestPMF(true);
  private static Properties PROPS;

  @BeforeClass
  public static void setUpBeforeClass() throws IOException, SQLException {
    EXECUTOR = Executors.newSingleThreadExecutor();
    PROPS = new Properties();
    PROPS.setProperty("database.username", System.getProperty("database.username", ""));
    PROPS.setProperty("database.password", System.getProperty("database.password", ""));
    PROPS.load(Thread.currentThread().getContextClassLoader().getResourceAsStream(TEST_DATABASE_PROPERTIES));
    initPMF(GBP_PMF, PROPS.getProperty("database.gbp.URL"), PROPS, ProductType.GBP);
  }

  @AfterClass
  public static void afterClass() {
    EXECUTOR.shutdown();
  }

  @Before
  public void setUp() throws Exception {
    // When someone uses this class from a unit test, we need to ensure transaction management still
    // results in a clean unit test database.
    Transaction.setNested();
  }

  @After
  public void tearDown() throws Exception {
    GBP_PMF.close();
  }

  private static void initPMF(final TestPMF pmf, final String databaseURL, final Properties props, final ProductType productType) throws SQLException {
    pmf.setJdbcURL(databaseURL);
    pmf.setDbUsername(props.getProperty("database.username"));
    pmf.setDbPassword(props.getProperty("database.password"));
    pmf.setProductType(productType);
  }

  protected static Properties getProperties() {
    return PROPS;
  }

  protected static TestPMF getGBPPMF() {
    return GBP_PMF;
  }

  protected static TestPMF getPMF(final ProductType productType) throws SQLException {
    switch (productType) {
    case GBP:
      return getGBPPMF();
    default:
      throw new IllegalArgumentException();
    }
  }

  protected Connection getGbpConnection() throws SQLException {
    return getConnection(GBP_PMF);
  }

  protected Connection getConnection(final ProductType productType) throws SQLException {
    return getConnection(getPMF(productType));
  }

  private static Connection getConnection(final TestPMF pmf) throws SQLException {
    return pmf.getConnection();
  }

  /**
   * Convenience method to get an input stream on a file. The caller should close
   * the stream.
   *
   * @param fileName file to read, it's relative to the calling class package
   * @return input stream to file
   * @throws FileNotFoundException
   */
  protected InputStream getFileInputStream(final String fileName) throws FileNotFoundException {
    final InputStream is = getClass().getResourceAsStream(fileName);
    if (is == null) {
      throw new FileNotFoundException("Input file not found:" + fileName);
    }
    return new BufferedInputStream(is);
  }
}
