import Foundation

class BasicView:CustomView {
    var container:Container!
    override func resolveSkin() {
        //StyleManager.addStylesByURL("~/Desktop/css/explorer/explorer.css")
        super.resolveSkin()
        var css:String = ""
        css += "Window Container#main{"
        css +=     "float:left;"
        css +=     "clear:left;"
        css +=     "padding-left:76px;"
        css +=     "padding-top:32px;"
        css += "}"
        css += "Card{"
        css +=     "fill:blue;"
        css +=     "float:left;"
        css += "}"
        Swift.print("hello world")
        StyleManager.addStyle(css)
        container = addSubView(Container(1000,800,self,"main")) as! Container
        createButton()
    }
    /**
     *
     */
    func createButton(){
        let card:Card = container.addSubView(Card(200/*CGFloat.NaN*/, 120/*CGFloat.NaN*/, "Buttons: ", container, "buttonCard")) as! Card
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
        //addSubView(Element(CGFloat.NaN, CGFloat.NaN, self, "ruler")) as! Element;
        //addSubView(Text(CGFloat.NaN, CGFloat.NaN, self.text, self, "cardText"));
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


