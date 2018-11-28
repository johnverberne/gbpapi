package nl.rivm.nca.pcraster;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Base64;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;

/**
 * Pushes a geotiff image to geoserver. The workspace it stores the image in must already exist for this to work.
 */
public class PublishGeotiff {

  private final String geoserverUrl;
  private final String encodedAuth;

  public PublishGeotiff(String geoserverUrl, String user, String password) {
    this.geoserverUrl = geoserverUrl;
    final String geoCreds = user + ":" + password;
    encodedAuth = new String(Base64.getEncoder().encodeToString(geoCreds.getBytes()));
  }

  public int publish(String workspaceName, String storeName, File file, String name) throws MalformedURLException, IOException {
    storeName += name;
    final String url = geoserverUrl + "rest/workspaces/" + workspaceName + "/coveragestores/" + storeName
        + "/file.geotiff?configure=first&coverageName=" + name;
    final HttpURLConnection con = (HttpURLConnection) new URL(url).openConnection();

    try {
      con.setRequestMethod("PUT");
      con.setRequestProperty("Authorization", "Basic " + encodedAuth);
      con.setRequestProperty("Content-type", "geotif/geotiff");
      con.setConnectTimeout(120000);
      con.setDoOutput(true);
      try (OutputStream output = con.getOutputStream(); FileInputStream input = FileUtils.openInputStream(file)) {
        IOUtils.copy(input, output);
        return con.getResponseCode();
      }
    } finally {
      con.disconnect();
    }
  }
}
