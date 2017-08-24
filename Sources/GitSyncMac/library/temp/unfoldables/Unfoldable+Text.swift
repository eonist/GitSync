import Foundation
@testable import Utils
@testable import Element

extension Text:UnFoldable{
    enum Key{
        static let text = "text"
    }
    var value:Any {
        get{return self.getText()}
        set{if let newValue:String = newValue as? String { self.setText(newValue) }}
    }
}
extension UnFoldable where Self:Text{
    static func unfold(dict:[String:Any]) -> UnFoldable{
        let elementConfig:ElementConfig = .init(dict)
        let text:String = UnfoldUtils.value(dict, "text") ?? ""
        return Text.init(text: text, size: elementConfig.size, id: elementConfig.id)
    }
}

