import Foundation

open class TextButton: Button {
   public lazy var textLabel: Label = createTextLabel()
   var textButtonStyle: TextButtonStyle {
      didSet {
         let style: Button.Style = (textButtonStyle.backgroundColor, textButtonStyle.borderColor, textButtonStyle.borderWidth, false)
         super.style = style
//         Swift.print("textButtonStyle.textColor:  \(textButtonStyle.textColor)")
         textLabel.textColor = textButtonStyle.textColor
      }
   }
   /*Text*/
   internal var text: String
   public init(text: String = "Default", style: TextButton.TextButtonStyle = defaultTextButtonStyle, frame: CGRect = .zero) {
      self.text = text
      self.textButtonStyle = style
      let style: Button.Style = (style.backgroundColor, style.borderColor, style.borderWidth, false)
      super.init(style: style, frame: frame)
      _ = textLabel
      _ = { self.textButtonStyle = self.textButtonStyle }()/*updates style, a trick to update didSet inside init*/
   }
   /**
    * Boilerplate
    */
   public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
