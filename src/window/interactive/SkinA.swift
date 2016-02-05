import Cocoa

//Continue here: Create a class that has a graphic and a trackingframe and also gets its parent in the init

class SkinA:InteractiveView2/*TrackingView*/{
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect:NSRect) {
        super.init(frame: frameRect)
        createContent()
    }
    func createContent(){
        let blueBox = RectGraphic(200,200,NSColor.blueColor())
        addSubview(blueBox.graphic)
        blueBox.draw()
        //blueBox.graphic.frame.origin = CGPoint(50,50)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}