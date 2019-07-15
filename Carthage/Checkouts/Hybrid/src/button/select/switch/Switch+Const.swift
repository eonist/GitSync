import Foundation
/**
 * Const
 */
extension Switch {
   public static let defaultSwitchStyles: SwitchStyles = (selected: selectedStyle, unSelected: unSelectedStyle)
   public static let selectedStyle: SwitchStyle = (foregroundColor: .green, backgroundColor: .lightGray)
   public static let unSelectedStyle: SwitchStyle = (foregroundColor: .lightGray, backgroundColor: .gray)
}
