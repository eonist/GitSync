import Cocoa

class WinView2:FlippedView{
    var element:Element?
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    //override var wantsUpdateLayer:Bool{return false;}
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        //wantsLayer = true
        createContent()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func drawRect(dirtyRect: NSRect) {
        //Swift.print("WinView.drawRect()")
        //super.drawRect(dirtyRect)
        //gradientBoxTest()
        //graphicsTest()
    }
    func createContent(){
        //testBorderAligment()
        testGraphic()
    }
    func testBorderAligment(){
        let css = "Element{fill:orange;fill-alpha:0.5;line:blue;line-alpha:0.5;line-offset-type:center;line-thickness:20px;}"
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        StyleManager.addStyle(styleCollection.styles)
        let element = Element(00,00,100,100)
        self.addSubview(element)
    }
    func testGraphic(){
        let a = GraphicsTest()
        self.addSubview(a)
    }
}