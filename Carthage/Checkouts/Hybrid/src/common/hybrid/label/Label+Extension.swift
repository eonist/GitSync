import Foundation
#if os(iOS)
import With
#elseif os(macOS)
import With_mac
#endif

extension Label {
   /**
    * Initiate
    * ## Examples:
    * let label:UILabel = .init(text:"Testing",style:(.systemFont(ofSize: 20),.black, .left))
    * addSubview(label)
    */
   public convenience init(text: String = "Default", style: Style = Label.defaultStyle, frame: CGRect = .zero) {
      self.init(frame: frame)
      with(self) {
         $0.textAlignment = style.textAlignement
         $0.font = style.font
         $0.textColor = style.textColor
         $0.text = text
      }
   }
   #if os(iOS)
   public func centerVertically() {
      /*Dont do anything, quick fix*/
   }
   #endif
}
/**
 * Type
 */
extension Label {
   public typealias Style = (font: Font, textColor: Color, textAlignement: NSTextAlignment)
}
/**
 * Const
 */
extension Label {
   public static let defaultStyle: Style = (font: .systemFont(ofSize: 20), textColor: .black, textAlignement: .left)
}
