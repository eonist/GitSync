import Foundation

class NodeList:Element{
    var index:Array<Int> = []
    var node:Node
    var itemHeight:CGFloat
    var list:List?
    init(_ width: CGFloat, _ height: CGFloat, _ itemHeight:CGFloat = CGFloat.NaN, _ node:Node? = nil, _ parent: IElement?, _ id: String? = "") {
        self.node = node!
        self.itemHeight = itemHeight
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        
        let xml = node.xml.childAt(index)
        
        let dp = DataProvider(xml)
        list = addSubView(List(width,height,itemHeight,dp,self))
    }
    
    //add listeners for list click
    
    //add listeners for node events
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
}
