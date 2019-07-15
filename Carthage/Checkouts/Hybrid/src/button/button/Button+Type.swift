import Foundation
/**
 * Type
 */
extension Button {
   /*Closure signatures*/
   public typealias UpInsideCallBack = () -> Void
   public typealias UpOutsideCallBack = () -> Void
   public typealias DownCallBack = () -> Void
   public typealias UpCallBack = () -> Void
   #if os(macOS)
   public typealias OverCallBack = () -> Void
   public typealias OutCallBack = () -> Void
   #endif
   /*Style*/
   public typealias Style = (backgroundColor: Color, borderColor: Color, borderWidth: CGFloat, isRounded: Bool)
}
