import Cocoa

class WinView5:FlippedView {
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        createContent()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    func createContent(){
        Swift.print("init")
        hitTesting()
    }
    func hitTesting(){
        Swift.print("hitTesting")
        //setup a blue box in a view (100x100) (use the view code from WindowView)
        let viewA:ViewA = ViewA(00,00)
        addSubView(viewA)
    }
}
class ViewA:InteractiveView2{
    init(_ width: CGFloat, _ height: CGFloat) {
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
        createContent()
    }
    func createContent(){
        Swift.print("ViewA create content")
        let skin = SkinA(NSRect(0,0,200,200),self)
        addSubview(skin)
        
        let viewB:ViewB! = ViewB(00,00)
        viewB.frame.origin = CGPoint(50,50)/**/
        addSubview(viewB)
    }
    override func mouseEntered(event: NSEvent) {
        Swift.print("ViewA.mouseEntered()")
        super.mouseEntered(event)
    }
    override func mouseExited(event: NSEvent) {
        Swift.print("ViewA.mouseExited()")
        super.mouseExited(event)
    }
    override func mouseOver() {
        //Swift.print("ViewA.mouseOver() ")
        super.mouseOver()
    }
    override func mouseOut() {
        //Swift.print("ViewA.mouseOut() ")
        super.mouseOut()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class ViewB:InteractiveView2{
    init(_ width: CGFloat, _ height: CGFloat) {
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!
        createContent()
    }
    func createContent(){
        Swift.print("ViewB create content")
        let skin = SkinB(NSRect(0,0,200,200),self)
        addSubview(skin)
    }
    override func mouseEntered(event: NSEvent) {
        Swift.print("ViewB.mouseEntered()")
        super.mouseEntered(event)
    }
    override func mouseExited(event: NSEvent) {
        Swift.print("ViewB.mouseExited()")
        super.mouseExited(event)
    }
    override func mouseOver() {
        //Swift.print("ViewB.mouseOver() ")
        super.mouseOver()
    }
    override func mouseOut() {
        //Swift.print("ViewB.mouseOut() ")
        super.mouseOut()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


//continue here: the quetion is does the parent recieve over when a child recieves over? and what are the implications of this?

//continue here: aswell as rollOver rollOut etc, test with 2 subSkins and make TrackingView

//try to change the size of the trackingframe aswell




