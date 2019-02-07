package nl.rivm.nca.receptors;

import java.io.Serializable;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;



/**
 * Simple point with x and y coordinate.
 */
public class Point extends Geometry implements Serializable {

  private static final long serialVersionUID = 6802697428089063814L;

  /**
   * If the SRID is not set then the system default SRID applies.
   */
  private static final int DEFAULT_SRID = 0;

  private int srid;
  private double x;
  private double y;
  private double xb;
  private double yb;

  // Needed for GWT.
  public Point() {
  }

  public Point(final double x, final double y) {
    this(x, y, DEFAULT_SRID);
  }

  public Point(final double x, final double y, final int srid) {
    this.x = x;
    this.y = y;
    this.srid = srid;
  }

  /**
   * Returns the distance of this Point to the provided Point.
   * @param other other point to measure distance
   * @return distance to other point
   */
  public double distance(final Point other) {
    final double tx = x - other.x;
    final double ty = y - other.y;

    return Math.sqrt(tx * tx + ty * ty);
  }

  @Override
  public boolean equals(final Object obj) {
    return obj instanceof Point && srid == ((Point) obj).srid
        && MathUtil.round(x) == MathUtil.round(((Point) obj).x) && MathUtil.round(y) == MathUtil.round(((Point) obj).y);
  }

  /**
   * @param systemSrid system SRID
   * @return Returns true if this point has SRID value 0 or equals to the given system SRID value.
   */
  public boolean isSystemSrid(final int systemSrid) {
    return srid == 0 || srid == systemSrid;
  }

  /**
   * Returns the srid.
   * NOTE: Do not test if this equals the system srid as it can be 0 in that case. Use: {@link #isSystemSrid(int)}.
   */
  public int getSrid() {
    return srid;
  }

  public double getX() {
    return x;
  }

  public double getY() {
    return y;
  }
  
  public double getXB() {
	  return xb;
  }
  
  public double getYB() {
	  return yb;
  }

  /**
   * Get the rounded value of x.
   * @return rounded x.
   */
  public int getRoundedX() {
    return (int) Math.round(x);
  }

  /**
   * Get the rounded value of y.
   * @return rounded y.
   */
  public int getRoundedY() {
    return (int) Math.round(y);
  }

  @Override
  public int hashCode() {
    final int prime = 31;
    final int bitShift = 32;
    int result = srid;
    long temp = Double.doubleToLongBits(x);
    result = prime * result + (int) (temp ^ (temp >>> bitShift));
    temp = Double.doubleToLongBits(y);
    result = prime * result + (int) (temp ^ (temp >>> bitShift));
    return result;
  }

  public void setSrid(final int srid) {
    this.srid = srid;
  }

  public void setX(final double x) {
    this.x = x;
  }

  public void setY(final double y) {
    this.y = y;
  }
  
  public void setXB(final double x) {
	  this.xb = x;
  }
  
  public void setYB(final double y) {
	  this.yb = y;
  }

  /**
   * Returns the point as WKT string. Coordinates are rounded to the nearest integer.
   *
   * @return the point as WKT string
   */
  public String toWKT() {
    return "POINT(" + MathUtil.round(x) + " " + MathUtil.round(y) + ")";
  }

  @Override
  public String toString() {
    return "Point [x=" + x + ", y=" + y + "]";
  }
}
