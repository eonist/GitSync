import Foundation

class NodeList:List{
    var node:Node
    init(_ width: CGFloat, _ height: CGFloat, _ itemHeight:CGFloat = CGFloat.NaN, _ node:Node? = nil, _ parent: IElement?, _ id: String? = "") {
        self.node = node!
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
        
    
}
