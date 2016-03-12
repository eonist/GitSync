import Foundation

class BasicView:CustomView {
    override func resolveSkin() {
        super.resolveSkin()
        Swift.print("hello world")
    }
}
class Card:Element{
    init(_ width: CGFloat, _ height: CGFloat, text:String = "", _ parent: IElement?, _ id: String?) {
        super.init(width, height, parent, id)
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


