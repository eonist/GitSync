import Foundation

/**
 * Const
 */
extension CheckButton {
   public static let defStyle: CheckBtnStyle = (.white, .black, true)
   public static let altStyle: CheckBtnStyle = (.black, .white, true)
   public static let defaultStyles: CheckBtnStyles = (active: altStyle, inActive: defStyle)
}
