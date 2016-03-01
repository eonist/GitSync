import Cocoa

class TestView5:AnimatableView {
    let target:CGPoint = CGPoint(60,200)
    var circ:EllipseGraphic!
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
                toggle ? CVDisplayLinkStart(displayLink) : CVDisplayLinkStop(displayLink);//To start capturing events from the display link, you'd use
                toggle = !toggle
            }
        }
        btn.event = onEvent
        
        let fill:FillStyle = FillStyle(NSColorParser.nsColor(0x4CD964))
        /*circ*/
        circ = EllipseGraphic(0,0,50,50,fill,nil)//create a circle that represents the object to animate
        addSubview(circ.graphic)
        circ.draw()
        circ.graphic.frame.y = 60
        
        //first add linear animation
        //then add ease out
        //then try to add springing
        //the try to add springing to a mouse movment test <--do this in another view
        //then try to make the scrollBar rubberBand effect
        //try to figure out how to apply custom time spans to tweening
    }
    override func onFrame(){
        Swift.print("onFrame")
        let epsilon:CGFloat = 0.15/*twips 20th of a pixel*/
        let easing:CGFloat = 0.2
        let dist = target.x - circ.graphic.frame.x
        
        if(!NumberAsserter.isNear(circ.graphic.frame.x, target.x, epsilon)){//animate a square 100 pixel to the right then stop the frame anim
            circ.graphic.frame.x += (dist * easing)
        }else{
            CVDisplayLinkStop(displayLink);
        }
        super.onFrame()
        
    }
}
