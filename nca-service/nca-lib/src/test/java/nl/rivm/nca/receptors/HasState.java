
package nl.rivm.nca.receptors;

/**
 * Data classes implementing this interface can provide a unique value
 * for its content. It's not the same as hashCode, which is used to identify
 * immutable properties of an object in a hash, while this interface is intended
 * to uniquely identify object based on the content of the object as a whole.
 * Thus providing the option of distinguishing between an object's current,
 * previous and future states.
 * 
 * <p>The same value of a StateHash can't be used on both the server and client. Or in other words. If a state hash was created on the client it
 * isn't necessary the same when calculated on the server or the other way around. This is due to java/JavaScript rounding differences.
 */
public interface HasState {

  /**
   * Returns a unique value representing this object's current state. The state value must return the same value for different objects if the content
   * that is relevant for the state is the same.
   *
   * @return int unique value
   */
  int getStateHash();
}
