import Foundation
@testable import Element
@testable import Utils

class TimeBar2:TimeBar{
    var items:[String]
    init(_ width: CGFloat, _ height: CGFloat, _ items:[String], _ parent: IElement?, _ id: String?) {
        self.items = items
        super.init(width, height, items.count, parent, id)
    }
    override func createItem(_ idx:Int){
        let spaceX:CGFloat = 100
        let x:CGFloat = (idx * spaceX)
        let str:String = items[idx]
        //Swift.print("str: " + "\(str)")
        let textArea:TextArea = TextArea(NaN,NaN,str,self)
        _ = addSubView(textArea)
        //Swift.print("CGPoint(x,0): " + "\(CGPoint(x,0))")
        textArea.setPosition(CGPoint(x,0))
    }
    override func getClassType() -> String {
        return "\(TimeBar.self)"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented") }
}
