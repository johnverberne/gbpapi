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
package nl.rivm.nca.db.util;

import java.text.MessageFormat;

/**
 * Simple join clause for a query.
 */
public class JoinClause {
  private static final String JOIN_PATTERN = " {0} JOIN {1} USING ({2})";

  /**
   * The type of join to use.
   */
  public enum JoinType {
    /**
     * An inner join.
     */
    INNER,
    /**
     * A left (outer) join.
     */
    LEFT
  }

  private final String join;
  private final String using;
  private final JoinClause.JoinType joinType;
  private final Attribute[] paramAttributes;

  /**
   * @param join The table or view to join.
   * @param using The attribute(s) to use to join the view to the query so far.
   * @param paramAttributes The attributes to use to refer to ? in the join (should be ordered properly).
   */
  public JoinClause(final String join, final String using, final Attribute... paramAttributes) {
    this(join, using, JoinType.INNER, paramAttributes);
  }

  /**
   * @param join The table or view to join.
   * @param using The attribute(s) to use to join the view to the query so far.
   * @param paramAttributes The attributes to use to refer to ? in the join (should be ordered properly).
   */
  public JoinClause(final String join, final Attribute using, final Attribute... paramAttributes) {
    this(join, using, JoinType.INNER, paramAttributes);
  }

  /**
   * @param join The table or view to join.
   * @param using The attribute(s) to use to join the view to the query so far.
   * @param joinType The type of join to use (default INNER)
   * @param paramAttributes The attributes to use to refer to ? in the join (should be ordered properly).
   */
  public JoinClause(final String join, final Attribute using, final JoinClause.JoinType joinType, final Attribute... paramAttributes) {
    this(join, using.attribute(), joinType, paramAttributes);
  }

  /**
   * @param join The table or view to join.
   * @param using The attribute(s) to use to join the view to the query so far.
   * @param joinType The type of join to use (default INNER)
   * @param paramAttributes The attributes to use to refer to ? in the join (should be ordered properly).
   */
  public JoinClause(final String join, final String using, final JoinClause.JoinType joinType, final Attribute... paramAttributes) {
    this.join = join;
    this.using = using;
    this.joinType = joinType != null ? joinType : JoinType.INNER;
    this.paramAttributes = paramAttributes;
  }

  protected String toJoinPart() {
    return MessageFormat.format(JOIN_PATTERN, joinType.name(), join, using);
  }

  protected Attribute[] getParamAttributes() {
    return paramAttributes;
  }

}
