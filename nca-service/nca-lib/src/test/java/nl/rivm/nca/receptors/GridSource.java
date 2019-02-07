package nl.rivm.nca.receptors;

public class GridSource {
	
	@SuppressWarnings("unused")
	private static final long serialVersionUID = -3467338449636297783L;

	private int srid;
	private double x;
	private double y;
	private double xb;
	private double yb;

	/**
	 * Returns the srid. NOTE: Do not test if this equals the system srid as it
	 * can be 0 in that case. Use: {@link #isSystemSrid(int)}.
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

}
