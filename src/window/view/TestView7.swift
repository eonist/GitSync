import Cocoa
/**
 * TODO: Setup the test class
 * TODO: setup a new list class
 * TODO: add the new list class here
 * TODO: test rubberband scrolling on list
 * TODO: move the AnimatableView class before or after interactive view, i guess bfore because we may have animatable views that are not interactive in the future
 * TODO: account for when the content is smaller than the crop
 * TODO: fix the styling of the list so that it fits inside the mask, use debug colors etc to figure out the bug
 */
class TestView7:CustomView {
    var sliderList:RBSliderList?
    override func resolveSkin() {
        super.resolveSkin()
        //testChaining()
        //testThumbButton()
        testRBList()
    }
    /**
     * 1. make a box
     * 2. animate  100px to the right
     * 3. start another animation that animates the box 100px down
     */
    func testChaining(){
        
        StyleManager.addStyle("Button{fill:#5AC8FA;float:left;clear:left;}Button:down{fill:#007AFF;}")
        let btn = addSubView(Button(100,24,self)) as! Button//add a button
        
        var animator:Animator?
        
        
        
        let fill:FillStyle = FillStyle(NSColorParser.nsColor(0x4CD964))
        /*circ*/
        let circ = EllipseGraphic(0,0,50,50,fill,nil)//create a circle that represents the object to animate
        addSubview(circ.graphic)
        circ.draw()
        circ.graphic.frame.y = 60
        
        func interpolateX(val:CGFloat){
            //Swift.print("interpolateX() val: " + "\(val)")
            circ.graphic.frame.x = val
        }
        
        func onEvent(event:Event){
            if(event.type == ButtonEvent.upInside && event.origin === btn){
                Swift.print("button works")
                animator = Animator(WindowParser.firstWindowOfType(IAnimatable)!,1,0,100,interpolateX,Easing.easeOutSine)
                animator!.start()
            }
        }
        btn.event = onEvent
    }
    func testThumbButton(){
        StyleManager.addStyle("Button{fill:blue;float:left;clear:left;}")
        let thumb = Thumb(50,140,self)
        addSubview(thumb)
        
       
        func interpolateAlpha(val:CGFloat){
            thumb.skin?.decoratables[0].getGraphic().fillStyle?.color = (thumb.skin?.decoratables[0].getGraphic().fillStyle?.color.alpha(val))!
            thumb.skin?.decoratables[0].draw()
        }
        let animator = Animator(Animation.sharedInstance,0.5,1,0,interpolateAlpha,Easing.easeInOutQuad)
        func onEvent(event:Event){
            if(event.type == ButtonEvent.upInside){
                Swift.print("click")
                animator.start()
            }
        }
        thumb.event = onEvent
        //thumb.applyOvershot(-0.25)
        //thumb.applyOvershot(1.25)
    }
    func testRBList(){
        StyleManager.addStylesByURL("~/Desktop/css/list.css")
        StyleManager.addStylesByURL("~/Desktop/css/slider.css")
        StyleManager.addStylesByURL("~/Desktop/css/sliderList.css")
        
        let dp = DataProvider(FileParser.xml("~/Desktop/scrollist.xml"))
        let section = self.addSubView(Section(200, 200, self, "listSection")) as! Section/*adds some visual space around the component*/
        sliderList = section.addSubView(RBSliderList(140,120,24,dp,section)) as? RBSliderList
    }
}