import Foundation
@testable import Utils
@testable import Element

class TreeList3Item:SelectCheckBoxButton,LableKind/*,ITreeListItem*/ {
    override func getClassType() -> String {
        return "\(TreeListItem.self)"
    }
    
}
