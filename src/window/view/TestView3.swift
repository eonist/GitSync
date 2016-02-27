import Cocoa

class TestView3:AnimatableView {
    var w:CGFloat = 200
    var h:CGFloat = 200
    override func resolveSkin() {
        super.resolveSkin()
        animTest()
    }
    func animTest(){
        let throwArea = addSubView(VerticalThrowArea())
        throwArea.frame.y = 40
        
        //create 3 color rectangles
        let fill:FillStyle = FillStyle(NSColor.redColor())
        /*Rect*/
        let rect = RectGraphic(0,0,w,h,fill,nil)//Add a red box to the view
        addSubview(rect.graphic)
        rect.draw()
        
        
        //rect.graphic.frame.y = 60
        
        //add these rectangles to a container that clips
        
        //write the a simple move code and hook up the DisplayLink
        
        //write the loop movment code
    }
}

class 