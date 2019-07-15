import Foundation

/**
 * Typealias
 */
extension TextButton {
   public typealias TextButtonStyle = (backgroundColor: Color, borderColor: Color, textColor: Color, borderWidth: CGFloat)
   public static let defaultTextButtonStyle: TextButtonStyle = (.white, .black, .black, 1)
   public static let alternateTextButtonStyle: TextButtonStyle = (.black, .white, .white, 1)
}
