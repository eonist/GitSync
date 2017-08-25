import Foundation
@testable import Utils
@testable import Element

extension Container:UnFoldable{}

extension UnFoldable where Self:Container{
    /**
     * New
     */
    static func unfold(dict:[String:Any]) -> UnFoldable{
        let element:ElementConfig = .init(dict)
        return Container.init(size:element.size, id:element.id)
    }
}
