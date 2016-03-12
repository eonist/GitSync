import Foundation

class BasicView:CustomView {
    override func resolveSkin() {
        super.resolveSkin()
        Swift.print("hello world")
    }
}
class Card:Element{
    var text:String;
    init(_ width: CGFloat, _ height: CGFloat, _ text:String = "", _ parent: IElement?, _ id: String?) {
        self.text = text
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


