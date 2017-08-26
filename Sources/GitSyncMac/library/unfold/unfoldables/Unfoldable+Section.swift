import Foundation
@testable import Utils
@testable import Element

extension Section:UnFoldable{
    enum Key{
        static let group = "group"
    }
}

extension UnFoldable where Self:Section{
    /**
     * New
     */
    static func unfold(dict:[String:Any]) -> UnFoldable{
        let element:ElementConfig = .init(dict)
        return Section.init(size:element.size, id:element.id)
    }
}

