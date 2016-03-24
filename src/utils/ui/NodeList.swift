import Foundation

class NodeList:Element{
    var node:Node
    var itemHeight:CGFloat
    init(_ width: CGFloat, _ height: CGFloat, _ itemHeight:CGFloat = CGFloat.NaN, _ node:Node? = nil, _ parent: IElement?, _ id: String? = "") {
        self.node = node!
        self.itemHeight = itemHeight
        super.init(width, height, parent, id)
    }
    
    //create a list here
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
}
