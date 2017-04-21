import Foundation
@testable import Utils
@testable import Element

class TreeList3Item:SelectCheckBoxButton/*,ITreeListItem*/ {
    override func getClassType() -> String {
        return "\(TreeList3Item.self)"
    }
}
