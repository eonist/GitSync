import Foundation

open class SelectButton: Button, Selectable {
   internal var styles: Styles
   open var selected: Bool {
      didSet {
         self.style = selected ? styles.active : styles.inActive
      }
   }
   public init(selected: Bool = false, styles: Styles = defaultStyles, frame: CGRect = .zero) {
      self.styles = styles
      self.selected = selected
      let style: Style = selected ? styles.active : styles.inActive
      super.init(style: style, frame: frame)
      _ = { self.selected = self.selected }()/*hack*/
   }
   /**
    * Boilerplate
    */
   public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
