import Foundation

/*******************************************************************************
 * PathBounds
 *
 * Represent a straight path with a start point and an end point.
 *
 ******************************************************************************/
struct PathBounds<T> {
  let start: T
  let end: T
}