package nl.rivm.nca.api.domain;

import nl.rivm.nca.db.PMF;
import nl.rivm.nca.db.ServerPMF;

public class ApiServiceContext {
  
  private PMF pmf;
  
  public ApiServiceContext() {};
  
  public ApiServiceContext(final PMF pmf) {
    this();
    this.pmf = pmf;
  }
  
  public PMF getPMF() {
    synchronized (this) {
      if (pmf == null) {
        pmf = ServerPMF.getInstance();
      }
      return pmf;
    }
  }

}
