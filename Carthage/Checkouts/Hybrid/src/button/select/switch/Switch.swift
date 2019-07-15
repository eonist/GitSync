import Foundation
#if os(iOS)
import Spatial
#elseif os(macOS)
import Spatial_macOS
#endif

open class Switch: Button, Selectable {
   var switchStyles: SwitchStyles
   public var switchStyle: SwitchStyle
   public lazy var foreground: SwitchForeground = createForeground()
   open var selected: Bool {
      didSet {
         Swift.print(":  \(self.selected)")
         self.switchStyle = self.selected ? switchStyles.selected : switchStyles.unSelected
//         self.caLayer?.borderColor = style.borderColor.cgColor
         super.style.backgroundColor = self.switchStyle.backgroundColor
         foreground.caLayer?.backgroundColor = self.switchStyle.foregroundColor.cgColor
//         Swift.print("selected:  \(selected)")
//         Swift.print("switchStyle.foregroundColor:  \(switchStyle.foregroundColor)")
//         self.caLayer?.borderWidth = style.borderWidth
         toggleForegroundPosition()
      }
   }
   /**
    * Initiate
    */
   public init(isSelected: Bool, styles: SwitchStyles = defaultSwitchStyles, frame: CGRect = .zero) {
      self.selected = isSelected
      self.switchStyles = styles
      self.switchStyle = isSelected ? styles.selected : styles.unSelected
//      let selectButtonStyle:SelectButton.Styles =
      let selectedStyle: Style = (styles.selected.backgroundColor, Color.clear, 0, true)
      let unSelectedStyle: Style = (styles.unSelected.backgroundColor, Color.clear, 0, true)
      let style: Style = isSelected ? selectedStyle : unSelectedStyle
      super.init(style: style, frame: frame)
      _ = foreground
      _ = { self.selected = self.selected }()/*hack*/
   }
   /**
    * Boilerplate
    */
   public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
