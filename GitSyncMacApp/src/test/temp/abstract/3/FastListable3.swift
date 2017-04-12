import Foundation

protocol FastListable3:Progressable3,Listable3{
    var selectedIdx:Int? {get set}
    var pool:[FastListItem] {get set}
    func reUse(_ listItem:FastListItem)
    func createItem(_ index:Int) -> Element
    var inActive:[FastListItem] {get set}
}
