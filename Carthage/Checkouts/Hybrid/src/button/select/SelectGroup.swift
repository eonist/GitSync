import Foundation

/**
 * - Note: this class also works great with RadioBullets
 * - Note: Use the SelectGroupModifier and SelectGroupParser for Modifing and parsing the SelectGroup
 * Fixme: ⚠️️ You could add a SelectGroupExtension class that adds Modifing and parsing methods to the SelectGroup instance!
 */
public class SelectGroup {
   public var selectables: [Selectable]
   public var selected: Selectable? {
      didSet {
         guard let selected = selected else { return }
         SelectGroup.unSelectAll(except: selected, selectables: selectables)
      }
   }
   public init(selectables: [Selectable], selected: Selectable? = nil) {
      self.selectables = selectables
      self.selected = selected
   }
}
extension SelectGroup {
   /**
    * Unselects all
    */
   public static func unSelectAll( except: Selectable, selectables: [Selectable]) {
      selectables.forEach {
         if $0 !== except && $0.selected { $0.selected = false }
      }
   }
}
