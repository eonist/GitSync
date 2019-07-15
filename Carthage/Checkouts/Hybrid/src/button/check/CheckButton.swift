import Foundation
/**
 * ## Examples:
 * let btn:CHeckButton= .init()
 * view.addSubview(btn)
 * btn.selected = true
 */
open class CheckButton: Button, Selectable {
   open var selected: Bool {
      didSet {
//         Swift.print("selected")
         self.checkButtonStyle = selected ? styles.active : styles.inActive
      }
   }
   /*Style*/
   internal var styles: CheckBtnStyles
   internal var checkButtonStyle: CheckBtnStyle {/*backgroundColor,borderColor,textColor*/
      didSet {
//         Swift.print("checkButtonStyle")
         self.caLayer?.borderWidth = 1
         self.caLayer?.borderColor = checkButtonStyle.borderColor.cgColor
         self.caLayer?.backgroundColor = checkButtonStyle.backgroundColor.cgColor
      }
   }
   /**
    * Initiate
    */
   public init(selected: Bool = false, styles: CheckBtnStyles = CheckButton.defaultStyles, frame: CGRect = .zero) {
      self.selected = selected
      self.styles = styles
      self.checkButtonStyle = selected ? styles.active : styles.inActive
      let style: Button.Style = (checkButtonStyle.backgroundColor, checkButtonStyle.borderColor, 1, checkButtonStyle.isRounded)
      super.init(style: style, frame: frame)
      /*Styling*/
      _ = { self.checkButtonStyle = self.checkButtonStyle }()/*hack*/
   }
   /**
    * Boilerplate
    */
   public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
