import Foundation

class BasicView:CustomView {
    override func resolveSkin() {
        StyleManager.addStylesByURL("~/Desktop/css/explorer/explorer.css")
        super.resolveSkin()
        Swift.print("hello world")
        createButton()
    }
    /**
     *
     */
    func createButton(){
        let card:Card = addSubView(Card(CGFloat.NaN, CGFloat.NaN, "Buttons: ", self, "buttonCard")) as! Card
        card
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
        addSubView(Element(CGFloat.NaN, CGFloat.NaN, self, "ruler")) as! Element;
        addSubView(Text(CGFloat.NaN, CGFloat.NaN, self.text, self, "cardText"));
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


