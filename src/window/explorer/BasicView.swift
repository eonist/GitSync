import Foundation

class BasicView:CustomView {
    var container:Container!
    override func resolveSkin() {
        StyleManager.addStylesByURL("~/Desktop/css/explorer/explorer.css")
        super.resolveSkin()
        var css:String = ""
        css += ""
        //StyleManager.addStyle(css)
        Swift.print("hello world")
        container = addSubView(Container(1000,800,self,"main"))
        createButton()
    }
    /**
     *
     */
    func createButton(){
        let card:Card = container.addSubView(Card(0/*CGFloat.NaN*/, 0/*CGFloat.NaN*/, "Buttons: ", container, "buttonCard"))
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
        addSubView(Element(0, 0, self, "ruler"))
        addSubView(Text(0/*CGFloat.NaN*/, 0/*CGFloat.NaN*/, text, self, "cardText"));
        addSubView(Button(96,24,self))
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


