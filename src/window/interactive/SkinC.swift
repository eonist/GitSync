import Cocoa

class SkinC:InteractiveView2{
    //override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect:NSRect) {
        super.init(frame: frameRect)
        createContent()
    }
    /**
     *
     */
    func createContent(){
        let blueBox = RectGraphic(frame.width,frame.height,NSColor.blueColor())
        addSubview(blueBox.graphic)
        blueBox.draw()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
