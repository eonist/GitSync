import Cocoa

class ViewA:InteractiveView2{
    init(_ width: CGFloat, _ height: CGFloat) {
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        /*self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!*/
        createContent()
    }
    func createContent(){
        Swift.print("ViewA create content")
        let skin = SkinA(frame:NSRect(0,0,0,0))
        addSubview(skin)
        
        //let viewB:ViewB! = ViewB(00,00)
        //viewB.frame.origin = CGPoint(50,50)/**/
        //addSubview(viewB)
    }
    override func mouseOver(event:MouseEvent) {
        if(event.origin === self){/*only trigger on skin, not descending UI*/}
        super.mouseOver(event)/*call super which propegates the call upstream to the parent UI element*/
    }
    override func mouseOut(event:MouseEvent) {
        if(event.origin === self){/*only trigger on skin, not descending UI*/}
        super.mouseOut(event)/*call super which propegates the call upstream to the parent UI element*/
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


