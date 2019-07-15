import Foundation

open class SelectableTextButton: TextButton, Selectable {
   internal var styles: Styles
   open var selected: Bool {
      didSet {
         self.textButtonStyle = selected ? styles.active : styles.inActive
      }
   }
   public init(selected: Bool = false, text: String = "Default", styles: Styles = defaultStyles, frame: CGRect = .zero) {
      self.styles = styles
      self.selected = selected
      let style: TextButtonStyle = selected ? styles.active : styles.inActive
      super.init(text: text, style: style, frame: frame)
      _ = { self.selected = self.selected }()/*hack*/
   }
   /**
    * Boilerplate
    */
   public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
