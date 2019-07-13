import Foundation
@testable import Utils
@testable import Element

extension Container:UnFoldable{}

extension UnFoldable where Self:Container{
    var value: Any {
        get {fatalError("error: \(self)")}
        set {fatalError("error: in \(self) \(newValue)")}
    }
    /**
     * New
     */
    static func unfold(dict:[String:Any]) throws -> UnFoldable{
        let element:ElementConfig = .init(dict)
        return Container.init(size:element.size, id:element.id)
    }
}
