import Foundation

public protocol Selectable: AnyObject {
   var selected: Bool { get set }//{get{return getSelected()}set{setSelected(newValue)}}
}
