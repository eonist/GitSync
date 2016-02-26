import Cocoa

class TestView2:CustomView{
    var rect:RectGraphic!
    private var displayLink: CVDisplayLink!
    override func resolveSkin() {
        super.resolveSkin()
        frameAnimTest()
    }
    func frameAnimTest(){
        StyleManager.addStyle("Button{fill:#5AC8FA;float:left;clear:left;}Button:down{fill:#007AFF;}")
        let btn = addSubView(Button(100,24,self)) as! Button//add a button
        
        var toggle:Bool = true
        func onEvent(event:Event){
            if(event.type == ButtonEvent.upInside && event.origin === btn){
                Swift.print("button works")
                toggle ? CVDisplayLinkStart(displayLink) : CVDisplayLinkStop(displayLink);//To start capturing events from the display link, you'd use
                toggle = !toggle
            }
        }
        btn.event = onEvent

        let fill:FillStyle = FillStyle(NSColorParser.nsColor(0x4CD964))
        /*Rect*/
        rect = RectGraphic(0,0,150,150,fill,nil)//Add a red box to the view
        addSubview(rect.graphic)
        rect.draw()
        rect.graphic.frame.y = 60
        
       

    }
    
    
    func onFrame(){
        //Swift.print("drawSomething")
        if(rect.graphic.frame.x < 100){//animate a square 100 pixel to the right then stop the frame anim
            rect.graphic.frame.x += 1
        }else{
            CVDisplayLinkStop(displayLink);
        }

        CATransaction.flush()//if you dont flush your animation wont animate and you get this message: CoreAnimation: warning, deleted thread with uncommitted CATransaction; set CA_DEBUG_TRANSACTIONS=1 in environment to log backtraces.
    }
}
