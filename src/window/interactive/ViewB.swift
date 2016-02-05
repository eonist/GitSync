import Cocoa

class ViewB:InteractiveView2{
    init(_ width: CGFloat, _ height: CGFloat) {
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
        /*self.wantsLayer = true/*if true then view is layer backed*/
        layer = CALayer()/*needs to be layer-hosted so that we dont get clipping of children*/
        layer!.masksToBounds = false//this is needed!!!*/
        createContent()
    }
    func createContent(){
        Swift.print("ViewB create content")
        //let skin = SkinB(NSRect(0,0,200,200),self)
        //addSubview(skin)
        
        let skin = SkinC()
        addSubview(skin)
    }
    /*override func mouseEntered(event: NSEvent) {
    //Swift.print("ViewB.mouseEntered()")
    //let hitView = hitTest(winMousePos)
    //Swift.print("hitView: " + "\(hitView)")
    super.mouseEntered(event)
    }*/
    /*override func mouseExited(event: NSEvent) {
    //Swift.print("ViewB.mouseExited()")
    super.mouseExited(event)
    }*/
    override func mouseOver(event:MouseEvent) {
        Swift.print("ViewB.mouseOver() ")
        super.mouseOver(event)
    }
    override func mouseOut(event:MouseEvent) {
        Swift.print("ViewB.mouseOut() ")
        super.mouseOut(event)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


//continue here: look at your composition UI elements, how do they handle different roll over/out scenarios






