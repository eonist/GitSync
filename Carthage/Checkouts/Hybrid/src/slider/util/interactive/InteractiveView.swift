import Foundation

internal class InteractiveView: GraphicView {
   /*Callbacks*/
   var onDown: CallBack = { _ in }
   var onUp: CallBack = { _ in }
   var onMove: CallBack = { _ in } // Fixme: rename to onDrag
}
/**
 * Type
 */
extension InteractiveView {
   typealias CallBack = (_ point: CGPoint) -> Void
}
