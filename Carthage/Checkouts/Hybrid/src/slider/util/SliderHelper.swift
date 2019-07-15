import Foundation

class SliderHelper {
   /**
    * Returns The progress derived from a node
    * RETURN: A number between 0 and 1
    */
   static func progress(mouseVal: CGFloat, tempMouseVal: CGFloat, side: CGFloat, thumbSide: CGFloat) -> CGFloat {
      if thumbSide == side { return 0 }/*if the thumbHeight is the same as the height of the slider then return 0*/
      let progress: CGFloat = (mouseVal - tempMouseVal) / (side - thumbSide)
      return max(0, min(progress, 1))/*Ensures that progress is between 0 and 1 and if its beyond 0 or 1 then it is 0 or 1*/
   }
   /**
    * Returns the position of a thumbs PARAM progress
    */
   static func thumbPosition(progress: CGFloat, side: CGFloat, thumbSide: CGFloat) -> CGFloat {
      let minThumbPos: CGFloat = side - thumbSide/*Minimum thumb position*/
      return progress * minThumbPos
   }
}
