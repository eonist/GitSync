import Cocoa
@testable import Utils
@testable import Element

class Archive {
    var window:NSWindow!
    /**
     *
     */
    init(){
        //stateTest()
        //themeSwitchTest()
        //testGraphXTest()
        //testGraphView2()
        
        
        //targetAnimationTest()
        //horizontalListTest()
        //animator2Test()
        //circle2RectAnimTest()
        //zoomBackAndForthAnimTest()
        //easer4Test()
        
    }
    /**
     * Springer4 tests
     */
    func springer4Test(){
        _ = {
            let animator = Springer4<CGFloat>(initValues,initSpringerConfig){ val in
                Swift.print("val: " + "\(val)")
            }
            animator.targetValue = 100
            animator.start()
        }()
        _ = {
            let animator = Springer4<CGPoint>(initPointValues,initPointSpringerConfig){ val in
                Swift.print("val: " + "\(val)")
            }
            animator.start()
        }
    }
    /**
     * Easer4 tests
     */
    func easer4Test(){
        _ = {
            let animator = Easer4<CGFloat>(initValues,initConfig){ val in
                Swift.print("val: " + "\(val)")
            }
            animator.targetValue = 100
            animator.start()
        }
        _ = {
            let animator = Easer4<CGPoint>(initPointValues,initPointConfig){ val in
                Swift.print("val: " + "\(val)")
            }
            animator.targetValue = CGPoint(100,100)
            animator.start()
        }()
    }
    /**
     *
     */
    func easer3Test(){
        
        //
        //        let initial = AnimationState(value: CGPoint(0.0,0.0), velocity: CGPoint(0.2,0.2), target: CGPoint(0,0), stopVelocity: CGPoint(0,0))
        //        let target = AnimationState(value: CGPoint(0.0,0.0), velocity: CGPoint(0.2,0.2), target: CGPoint(100,100), stopVelocity: CGPoint(0,0))
        //        let animator = Easer3(initial: initial, target: target, damping: CGPoint(0.2,0.2)) { (value:CGPoint) in
        //            Swift.print("value: " + "\(value)")
        //        }
        //        animator.start()
        
        
        
        //animator.stopped
        
    }
    /**
     *
     */
    func zoomBackAndForthAnimTest(){
        //Setup window 200x300,white
        let winRect = CGRect(0,0,200,300)
        window.size = winRect.size
        window.contentView = InteractiveView2()
        window.title = ""
        
        StyleManager.addStyle("#bg{fill:white;}")
        window.contentView?.addSubview(Section(window.size.w,window.size.h,nil,"bg"))
        
        //circle, 70-radius,centered
        
        let startRect:CGRect = {
            let size:CGSize = CGSize(70,70)
            let p:CGPoint = Align.alignmentPoint(size, winRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
        }()
        
        let startColor:NSColor = .gray
        let startFillet:CGFloat = 20
        //roundRect, 150x150, Fillet:25, centered
        let endRect:CGRect = {
            let size:CGSize = CGSize(150,150)
            let p:CGPoint = Align.alignmentPoint(size, winRect.size, Alignment.centerCenter, Alignment.centerCenter)
            return CGRect(p,size)
        }()
        let endColor:NSColor = .black
        let endFillet:CGFloat = 35
        
        let roundRect:RoundRectGraphic = {
            let roundRect = RoundRectGraphic(0,0,startRect.w,startRect.h,Fillet(startFillet),FillStyle( startColor.interpolate(endColor, 0)),nil)
            window.contentView?.addSubview(roundRect.graphic)
            roundRect.draw()
            roundRect.graphic.layer?.position = startRect.origin
            return roundRect
        }()
        
        
        /*Elastic anim to roundRect state*/
        let anim = Animator2.init(initValues:(dur:0.8,from:0,to:1), easing:Easing.elastic.easeOut) { value in
            disableAnim {
                Swift.print("value: " + "\(value)")
                /*Fillet*/
                let fillet:Fillet = Fillet(startFillet.interpolate(endFillet, value))
                roundRect.fillet = fillet
                
                /*Color*/
                let color = startColor.interpolate(endColor, value)
                roundRect.graphic.fillStyle = FillStyle(color)
                
                /*Size*/
                let newSize = startRect.size.interpolate(endRect.size, value)
                roundRect.size = newSize
                
                /*Position*/
                let newP = startRect.origin.interpolate(endRect.origin, value)
                roundRect.graphic.layer?.position = newP
                
                /*Draw it all*/
                roundRect.draw()
            }
        }
        anim.completed = {
            bgSleep(1){/*delay anim for 1 secs*/
                anim.initValues = (dur:0.8,from:1,to:0)/*reverse*/
                anim.currentFrameCount = 0/*reset*/
                anim.completed = {}/*reset*/
                anim.start()/*start the reverse anim*/
            }
        }
        
        bgSleep(30){/*delay anim for 2 secs*/
            anim.start()
        }
        //reverse
        
    }
    /**
     *
     */
    func circle2RectAnimTest(){
        /*Setup a window*/
        let rect = CGRect(0,0,200,300)
        window.size = rect.size
        window.contentView = InteractiveView2()
        window.title = ""
        
        StyleManager.addStyle("#bg{fill:white;}")
        window.contentView?.addSubview(Section(window.size.w,window.size.h,nil,"bg"))
        
        /*The modal shape that pops up*/
        let startRect2 = CGRect.init(rect.center,CGSize(0,0))
        let roundRect2:RoundRectGraphic = {
            let roundRect = RoundRectGraphic(0,0,startRect2.w,startRect2.h,Fillet(0),FillStyle(NSColor.yellow.alpha(0)),nil)
            window.contentView?.addSubview(roundRect.graphic)
            roundRect.draw()
            roundRect.graphic.layer?.position = startRect2.origin
            return roundRect
        }()
        
        /*The blue circle shape*/
        let startRect = CGRect.init(CGPoint(50,100),CGSize(100,100))
        let roundRect:RoundRectGraphic = {
            let roundRect = RoundRectGraphic(0,0,startRect.w,startRect.h,Fillet(50),FillStyle(.blue),nil)
            window.contentView?.addSubview(roundRect.graphic)
            roundRect.draw()
            roundRect.graphic.layer?.position = startRect.origin
            return roundRect
        }()
        
        let anim1 = Animator2.init(initValues:(dur:0.6,from:0,to:1), easing:Easing.expo.easeOut) { value in
            disableAnim {
                /*roundRect1*/
                _ = {
                    /*Fillet*/
                    let fillet:Fillet = Fillet(50+(-25*value))
                    roundRect.fillet = fillet
                    
                    /*Color*/
                    let color = NSColor.blue.interpolate(.red, value)
                    roundRect.graphic.fillStyle = FillStyle(color)
                    
                    /*Size*/
                    let endSize = CGSize(150,50)
                    let newSize = startRect.size.interpolate(endSize, value)
                    roundRect.size = newSize
                    
                    /*Position*/
                    let endP = CGPoint(25,25)
                    let newP = startRect.origin.interpolate(endP, value)
                    roundRect.graphic.layer?.position = newP
                    
                    /*Draw it all*/
                    roundRect.draw()
                }()
                /*roundRect2*/
                _ = {
                    /*Fillet*/
                    let fillet:Fillet = Fillet((25*value))
                    roundRect2.fillet = fillet
                    
                    /*Color*/
                    let color = NSColor.green.interpolate(NSColor.green.alpha(1), value)
                    roundRect2.graphic.fillStyle = FillStyle(color)
                    
                    /*Size*/
                    let endSize = CGSize(150,150)
                    let newSize = startRect2.size.interpolate(endSize, value)
                    roundRect2.size = newSize
                    
                    /*Position*/
                    let endP = CGPoint(25,100)
                    let newP = startRect2.origin.interpolate(endP, value)
                    roundRect2.graphic.layer?.position = newP
                    
                    /*Draw it all*/
                    roundRect2.draw()
                }()
            }
        }
        anim1.completed = {
            bgSleep(1){/*delay anim for 1 secs*/
                anim1.initValues = (dur:0.6,from:1,to:0)/*reverse*/
                anim1.currentFrameCount = 0/*reset*/
                anim1.completed = {}/*reset*/
                anim1.start()/*start the reverse anim*/
            }
        }
        
        bgSleep(30){/*delay anim for 2 secs*/
            anim1.start()
        }
        
    }
    /**
     *
     */
    func animator2Test(){
        /*Setup a window*/
        window.size = CGSize(200,200)
        window.contentView = InteractiveView2()
        window.title = ""
        
        /*Ellipse*/
        //        let newColor = NSColor.blue.interpolate(.red, 1)
        let ellipse = RectGraphic(10,10,100,100,FillStyle(.blue),nil)
        window.contentView?.addSubview(ellipse.graphic)
        ellipse.draw()
        
        let anim1 = Animator2(initValues:Animator2.initValues){ value in/*This method gets called 60FPS, add the values to be manipulated here*/
            Swift.print("value: " + "\(value)")
            disableAnim {/*Important so that you don't get the apple "auto" anim as well*/
                ellipse.graphic.layer?.position = CGPoint(100*value,0)/*We manipulate the layer because it is GPU accelerated as oppose to setting the view.position which is slow*/
            }
        }
        let anim2 = Animator2(initValues:(dur:0.5,from:1,to:0)) { value in//adds a new anim block to the completed callBack
            Swift.print("value: " + "\(value)")
            disableAnim {/*Important so that you don't get the apple "auto" anim as well*/
                ellipse.graphic.layer?.position = CGPoint(100*value,0)/*We manipulate the layer because it is GPU accelerated as oppose to setting the view.position which is slow*/
            }
        }
        anim1.completed = {
            Swift.print("anim1 completed")
            sleep(2)
            anim2.start()//start the second anim right after the first started
        }
        let anim3 = Animator2(initValues: (dur:2.2,from:0,to:1)){ value in
            disableAnim {
                let color = NSColor.blue.interpolate(.red, value)
                ellipse.graphic.fillStyle = FillStyle(color)
                ellipse.draw()
            }
            }.onComplete {//this is the final complete call in the chain
                Swift.print("entire anim sequence completed 🏆")
        }
        anim2.completed = {
            sleep(2)
            anim3.start()
        }
        let anim4 = Animator2(initValues: (dur:2.2,from:0,to:1)){ value in
            disableAnim {
                let color = NSColor.red.interpolate(.blue, value)
                ellipse.graphic.fillStyle = FillStyle(color)
                ellipse.draw()
            }
        }
        anim3.completed = {
            sleep(CGFloat(0.4).int.uint32)
            anim4.start()
        }
        
        
        bgSleep(30){/*start anim after 2 sec, but doesn't block the app*/
            anim1.start()/*initiates the animation chain*/
        }
    }
    /**
     *
     */
    func horizontalListTest(){
        //window
        window.size = CGSize(664,400)
        window.contentView = InteractiveView2()
        window.title = ""
        //scrollList
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/general.css",true)
        
        /*let button = Button(120,24)
         window.contentView?.addSubview(button)*/
        
        
        
        StyleManager.addStyle("#listContainer{fill:red;float:left;clear:left;}")
        let section = Section(300,400,nil,"listContainer")
        window.contentView!.addSubview(section)
        
        let xml = FileParser.xml("~/Desktop/assets/xml/longlist.xml".tildePath)
        let dp:DP = DP(xml)
        let list = ScrollFastList3(140, 140, CGSize(24,24), dp,section,"",.ver)
        section.addSubview(list)
        
        //
        //list.selectAt(1)
        /**/
        //then make custom scrolllist
    }
    /**
     *
     */
    func targetAnimationTest(){
        //animate to to target
        //then we change the target and the ball should gravitate towards this new target
        
        //Setup a window
        window.size = CGSize(664,400)
        window.contentView = InteractiveView2()
        window.title = ""
        
        StyleManager.addStyle("#bg{fill:white;}")
        let bg = window.contentView?.addSubView(Button(window.size.w,window.size.h,nil,"bg"))
        
        /*Ellipse*/
        let ellipse = EllipseGraphic(-50,-50,100,100,FillStyle(.blue),nil)
        window.contentView?.addSubview(ellipse.graphic)
        ellipse.draw()
        
        func progress(value:CGPoint){/*This method gets called 60FPS, add the values to be manipulated here*/
            disableAnim {/*Important so that you don't get the apple "auto" anim as well*/
                ellipse.graphic.layer?.position = value/*We manipulate the layer because it is GPU accelerated as oppose to setting the view.position which is slow*/
            }
        }
        let animator = PointEaser(progress, PointEaser.initValues,PointEaser.initConfig)/*Setup interuptable animator*/
        func onViewEvent(_ event:Event) {/*This is the click on window event handler*/
            if event.type == ButtonEvent.upInside {
                animator.targetValue = bg!.localPos()/*Set the position of where you want the anim to go*/
                if animator.stopped {animator.start()}/*We only need to start the animation if it has already stopped*/
            }
        }
        bg?.event = onViewEvent
        
        //update mover target on window event mouseUpEvent
    }
    /**
     * Testing the zoomable and bouncing graph
     */
    func testGraphXTest(){
        Swift.print("Hello GraphX")
        
        window.size = CGSize(664,400)
        window.title = ""
        window.contentView = InteractiveView2()
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/graphx/graphxtest.css",true)
        
        let winSize:CGSize = WinParser.size(window)
        let graph = window.contentView!.addSubView(GraphX(winSize.w,winSize.h))
        _ = graph
    }
    /**
     * Earlier test that modulates the graph while you scroll
     */
    func testGraphView2(){
        window.size = CGSize(664,400)
        window.contentView = InteractiveView2()
        let winSize:CGSize = WinParser.size(window)
        let test = window.contentView!.addSubView(GraphView2(winSize.w,winSize.h))
        _ = test
    }
}
