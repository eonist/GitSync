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
        let card:Card = container.addSubView(Card(200/*CGFloat.NaN*/, 120/*CGFloat.NaN*/, "Buttons: ", container, "buttonCard"))
        let button = card.addSubView(Button(96,24,card))
        func onbuttonDown(event:Event){
            if(event.type == ButtonEvent.upInside){
                //var startTime:int = getTimer();
                //StyleResolver.style(event.target as Button);
                //print("selectRow-duration: " + (getTimer() - startTime));
            }
        }
        button.event = onbuttonDown
    }
    /**
    * TextButton
    */
    private function createTextButton():void{
    var textButtonSection:Section = stage.addChild(new Section(NaN, NaN, "TextButton: ", this, "textButtonSection")) as Section;
    var textButton:TextButton = textButtonSection.addChild(new TextButton(96,24,false,false,"Button",textButtonSection)) as TextButton;
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
        addSubView(Text(CGFloat.NaN, CGFloat.NaN, text, self, "cardText"));
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


