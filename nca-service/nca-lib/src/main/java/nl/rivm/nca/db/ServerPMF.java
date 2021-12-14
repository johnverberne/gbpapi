package nl.rivm.nca.db;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ServerPMF implements PMF {
  String DATASOURCE_NAME = "jdbc/ncaDB";
  static Logger LOGGER = LoggerFactory.getLogger(ServerPMF.class);
  
  private static ServerPMF instance;
  
  private final DataSource ds;
  
  private ServerPMF() throws NamingException {
    final Context initCtx = new InitialContext();
    final Context envCtx = (Context) initCtx.lookup("java:comp/env");
    ds = (DataSource) envCtx.lookup(DATASOURCE_NAME);
  }
  
  public static ServerPMF getInstance() {
    if (instance == null) {
      try {
      instance = new ServerPMF();
      } catch (final NamingException e) {
        LOGGER.error("Data source for database connection is't correct", e);
        throw new RuntimeException(e);
      }
      
    }
    return instance;
  }
  
  public Connection getConnection() throws SQLException {
    try {
      return ds.getConnection();
    } catch (final SQLException e) {
      throw e;
    }
  }

@Override
public String getDatabaseVersion() throws SQLException {
	return "1";
}

}
