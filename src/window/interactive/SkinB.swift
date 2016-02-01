import Cocoa

class SkinB:TrackingView{
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(_ frameRect:NSRect,_ parent:NSView) {
        super.init(frameRect, parent)
        createContent()
    }
    func createContent(){
        let redBox:RoundRectGraphic = RoundRectGraphic(0,0,200,200,Fillet(50),FillStyle(NSColor.redColor()),LineStyle(5,NSColor.greenColor()),OffsetType(OffsetType.center))
        addSubview(redBox.graphic)
        redBox.draw()
        //redBox.graphic.frame.origin = CGPoint(50,50)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

