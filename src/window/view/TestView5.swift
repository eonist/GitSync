import Cocoa

class TestView5:AnimatableView {
    override func resolveSkin() {
        super.resolveSkin()
        motionTest()
    }
    /**
     * RobertPenner.com has many nice easeing equation you can recycle
     */
    func motionTest(){
        //Create a button to start the animation
        StyleManager.addStyle("Button{fill:#5AC8FA;float:left;clear:left;}Button:down{fill:#007AFF;}")
        let btn = addSubView(Button(100,24,self)) as! Button//add a button
        
        var toggle:Bool = true
        func onEvent(event:Event){
            if(event.type == ButtonEvent.upInside && event.origin === btn){
                Swift.print("button works")
            }
        }
        btn.event = onEvent
        
        let fill:FillStyle = FillStyle(NSColorParser.nsColor(0x4CD964))
        /*Rect*/
        circ = RectGraphic(0,0,150,150,fill,nil)//Add a red box to the view
        addSubview(rect.graphic)
        rect.draw()
        rect.graphic.frame.y = 60
        //create a circle that represents the object to animate
        //first add inear animation
        //then add ease out
        //then try to add springing
        //the try to add springing to a mouse movment test <--do this in another view
        //then try to make the scrollBar rubberBand effect
    }
}
