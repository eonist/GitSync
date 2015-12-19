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
    }
    func createContent(){
        //testBorderAligment()
        testGraphic()
    }
    func testGraphic(){
        let a = TempGraphic()
        a.frame.origin = (NSPoint(100,100))
        a.layer!.masksToBounds = false
        Swift.print("a.frame: " + "\(a.frame)")
        Swift.print("a.layer?.frame: " + "\(a.layer?.frame)")
        self.addSubview(a)
        Swift.print("a.frame: " + "\(a.frame)")
        
        //let rect = CGRect(0,0,100,100)
        let b = TempGraphic()
        a.addSubview(b)
        a.layer!.masksToBounds = false
        b.frame.origin = (NSPoint(-50,50))
        b.layer!.masksToBounds = false
    }
}