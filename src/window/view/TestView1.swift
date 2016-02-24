import Cocoa
import OpenGL.GL3

/**
 * TODO: Hook up the onWindowResize method
 */
class TestView1:WindowView{
    var section:Section?
    var closeButton:Button?
    var minimizeButton:Button?
    var maximizeButton:Button?
    
    /**
     * Add content here
     */
    override func resolveSkin() {
        super.resolveSkin()
        //Swift.print("CustomView.resolveSkin()")
        createTitleBar()
        frameAnimTest()
        //animationTest()
        //sliderTest()
        //sliderListTest()
        //xmlListTest()
        
        //textButtonTest()
        //listTest()
        //dataProviderTest()
        //createCheckBoxButton()
        //createCheckBox()
        
        //createTextInput()
        //createSingleLineTextArea()
        //createText()
        //createLeverSpinner()
        //createLeverStepper()
        
        //createRadioBullets()
        //addEventListeners()
        
        /*
        let tempTextInput = TempTextInput()
        addSubview(tempTextInput)
        tempTextInput.frame.origin.y = 50
        */
        
        //buttonTest()
    }
    //var displayLink:CVDisplayLink?
    private var displayLink: CVDisplayLink!
    //var displayID:CGDirectDisplayID?
    //var error:CVReturn? = kCVReturnSuccess
    var rect:RectGraphic!
    func frameAnimTest(){
        
        StyleManager.addStyle("Button{fill:#5AC8FA;float:left;clear:left;}Button:down{fill:#007AFF;}")
        let btn = addSubView(Button(100,24,self)) as! Button//add a button
        
        
        var toggle:Bool = true
        func onEvent(event:Event){
            if(event.type == ButtonEvent.upInside && event.origin === btn){
                //do something here
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
        rect.graphic.frame.y = 60/**/
        
        displayLink = setUpDisplayLink()
        
        Swift.print("displayLink: " + "\(displayLink)")
        
        //animate a square 100 pixel to the right then stop the frame anim
        /*displayID = CGMainDisplayID();
        
        let pointer = UnsafeMutablePointer<CVDisplayLink?>(unsafeAddressOf(self))
        
        Swift.print("pointer: " + "\(pointer)")
        
        error = CVDisplayLinkCreateWithCGDisplay(displayID!, pointer)*/
        
        
        
        //
        
        
        
        /*if let error = error {
        Swift.print("An error occurred \(error)")
        } else {
        Swift.print("no error")
        }*/
    }
    /**
     *
     */
    func drawSomething(){
        //Swift.print("drawSomething")
        
        
        
        
        //  Grab a context from our view and make it current for drawing into
        //  CVDisplayLink uses a separate thread, lock focus or our context for thread safety
        
        
        //Swift.print("self.openGLContext: " + "\(self.openGLContext)")
        
        /**/
        /*let context:NSOpenGLContext = NSOpenGLContext.currentContext()!
        
        Swift.print("context: " + "\(context)")
        
        context.makeCurrentContext()
        CGLLockContext(context.CGLContextObj)*/
        
        
        //rect.graphic.fillShape.graphics.context = context.
        if(rect.graphic.frame.x < 100){
            rect.graphic.frame.x += 1
        }else{
            CVDisplayLinkStop(displayLink);
        }
        
        rect.graphic.display()
        
        CATransaction.flush()
        
        //continue here: gather more information, start a project from scrath to not clutter up the framework anymore. 
        //also maybe just try the NSTimer, and then revisit CVDisplayLink later
        
        /*
        
        //  Clear the context, set up the OpenGL shader program(s), call drawing commands
        //  OpenGL targets and such are UInt32's, cast them before sending in the OpenGL function
        
        glClear(UInt32(GL_COLOR_BUFFER_BIT))
        
        //  We're using a double buffer, call CGLFlushDrawable() to swap the buffer
        //  We're done drawing, unlock the context before moving on
        
        CGLFlushDrawable(context.CGLContextObj)
        CGLUnlockContext(context.CGLContextObj)*/
        
        
        /**/
        
        

        
        
        
    }
    
    func setUpDisplayLink() -> CVDisplayLink {
        var displayLink: CVDisplayLink?

        var status = kCVReturnSuccess
        status = CVDisplayLinkCreateWithActiveCGDisplays(&displayLink)
        Swift.print("status: " + "\(status)")
        
        
        /* Set up DisplayLink. */
        func displayLinkOutputCallback( displayLink: CVDisplayLink,_ inNow: UnsafePointer<CVTimeStamp>, _ inOutputTime: UnsafePointer<CVTimeStamp>,_ flagsIn: CVOptionFlags, _ flagsOut: UnsafeMutablePointer<CVOptionFlags>,_ displayLinkContext: UnsafeMutablePointer<Void>) -> CVReturn{
            //Swift.print("works")
            
           
            
            
            unsafeBitCast(displayLinkContext, CustomView.self).drawSomething()//drawRect(unsafeBitCast(displayLinkContext, NSOpenGLView.self).frame)
            return kCVReturnSuccess
        }
       
        
        let outputStatus = CVDisplayLinkSetOutputCallback(displayLink!, displayLinkOutputCallback, UnsafeMutablePointer<Void>(unsafeAddressOf(self)))
        Swift.print("outputStatus: " + "\(outputStatus)")
        
        
        let displayID = CGMainDisplayID()
        let displayIDStatus = CVDisplayLinkSetCurrentCGDisplay(displayLink!, displayID)
        Swift.print("displayIDStatus: " + "\(displayIDStatus)")
        
        return displayLink!
    }
    
   
    
    
    /**
     *
     */
    func animationTest(){
        StyleManager.addStyle("Button{fill:#5AC8FA;float:left;clear:left;}Button:down{fill:#007AFF;}")
        let btn = addSubView(Button(100,24,self)) as! Button//add a button
        
       
        //let fill:FillStyle = FillStyle(NSColorParser.nsColor(0x4CD964))
        let gradient = LinearGradient(Gradients.deepPurple(),[],π/2)
        let lineGradient = LinearGradient(Gradients.purple(0.5),[],π/2)
        /*Styles*/
        let fill:GradientFillStyle = GradientFillStyle(gradient);
        let lineStyle = LineStyle(20,NSColorParser.nsColor(Colors.green()).alpha(0.5),CGLineCap.Round)
        let line = GradientLineStyle(lineGradient,lineStyle)
        
        /*Rect*/
        /*let rect = RectGraphic(0,0,150,150,fill,line)//Add a red box to the view
        addSubview(rect.graphic)
        rect.draw()
        rect.graphic.frame.y = 60*/
        
        let rect = RoundRectGraphic(0,00,200,200,Fillet(75),fill.mix(Gradients.red()),line.mix(Gradients.orange(0.5)))
        addSubview(rect.graphic)
        rect.draw()
        rect.graphic.frame.y = 60
        
        
        func onEvent(event:Event){
            if(event.type == ButtonEvent.upInside && event.origin === btn){
                //do something here
                Swift.print("button works")

                
                
                
                let swapAnimation:CATransition = CATransition()
                swapAnimation.type = kCATransitionPush;
                //swapAnimation.subtype = kCATransitionTypeFromUITableViewRowAnimation(animation);
                swapAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                swapAnimation.fillMode = kCAFillModeBoth
                swapAnimation.duration = 1.75
                swapAnimation.removedOnCompletion = true
                swapAnimation.delegate = rect.graphic//sets the instance that will get the animationDidStart callBack and the animationDidEnd callback
                //[self.layer addAnimation:swapAnimation forKey:@"UITableViewReloadDataAnimationKey"];
                rect.graphic.layer?.addAnimation(swapAnimation, forKey: "doesntmatter")
                
                
                
                
                //rect.graphic.frame.x += 100//try to move this red box 100 px to the left
                CATransaction.begin()
                
                //let newFill:FillStyle = FillStyle(NSColor.random)//NSColorParser.nsColor(0xFFCC00)
                rect.graphic.fillStyle = fill
                rect.graphic.lineStyle = line
                (rect).fillet = Fillet(0)
                rect.draw()
                
                
                
                

                CATransaction.flush()

                CATransaction.commit()

                                /*
                
                let animation:CABasicAnimation = CABasicAnimation()
                animation.keyPath = "contents"
                animation.fromValue = 0;
                animation.toValue = 100;
                //animation.repeatDuration /*This property specifies how long the animation should repeat. The animation repeats until this amount of time has elapsed. It should not be used with repeatCount.*/
                //animation.repeatCount = 1/*The default is zero, which means that the animation will only play back once. To specify an infinite repeat count, use 1e100f. This property should not be used with repeatDuration.*/
                //animation.timeOffset = 0.0 /*If a time offset is set, the animation won’t actually become visible until this amount of time has elapsed in relation to the time of the parent group animation’s duration.*/
                //animation.beginTime = 0.0 /*This property is useful in an animation group. It specifies a time for the animation to begin playing in relation to the time of the parent group animation’s duration.*/
                //animation.speed = 1 /*The default value for this property is 1.0. This means that the animation plays back at its default speed. If you change the value to 2.0, the animation plays back at twice the default speed. This in effect splits the duration in half. If you specify a duration of 6 seconds and a speed of 2.0, the animation actually plays back in three seconds—half the duration specified.*/
                animation.duration = 1/* It sets the amount of time to be taken between the fromValue and toValue of the animation. Duration is also affected by the speed property.*/
                animation.fillMode = kCAFillModeForwards
                animation.removedOnCompletion = false/*The default value for this property is YES, which means that when the animation has finished its specified duration, the animation is automatically removed from the layer. This might not be desirable. If you want to animate the property you’ve speci- fied again, for example, you want to set this property to NO. That way, the next time you call –set on the property being animated in the animation, it will use your animation again rather than the default.*/
                //animation.autoreverses = true//returns the animation to its origin
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)//kCAMediaTimingFunctionEaseIn,kCAMediaTimingFunctionEaseOut,kCAMediaTimingFunctionEaseInEaseOut,kCAMediaTimingFunctionDefault,kCAMediaTimingFunctionLinear
                //functionWithControlPoints:0.5:0:0.9:0.7
                //CAMediaTimingFunction(controlPoints: 0.5, 0, 0.9, 0.7)//bezier curve animation
                //you can start multiple animations with : CAAnimationGroup.
                
                rect.graphic.layer!.addAnimation(animation, forKey: "basics")//:animation forKey:@"basic"];
                //rect.graphic.layer!.position = CGPointMake(100, 60);
                
                */
            }
        }
        btn.event = onEvent
    }
    /**
     *
     */
    func sliderTest(){
        //add slider and test
        
        StyleManager.addStylesByURL("~/Desktop/css/slider.css")
        
        var css:String = ""
        css += "Container#sliderContainer{"
        css +=      "float:left;"
        css +=      "clear:left;"
        css +=      "fill:green;"
        css +=      "fill-alpha:0;"
        //css +=      "padding-left:20px;"
        //css +=      "padding-top:20px;"
        //css +=      "margin-left:12px;"
        //css +=      "margin-top:12px;"
        css += "}"
        StyleManager.addStyle(css)
        
        let container = addSubView(ScrollContainer(120,120,self,"sliderContainer")) as! Container
        //let section = self.addSubView(Section(200, 200, self, "sliderSection")) as! Section/*this instance represents the inset shadow bagground and also holds the buttons*/
        container
        
        
        
    }
    /**
     *
     */
    func sliderListTest(){
        
        StyleManager.addStylesByURL("~/Desktop/css/list.css")
        StyleManager.addStylesByURL("~/Desktop/css/slider.css")
        StyleManager.addStylesByURL("~/Desktop/css/sliderList.css")
        
        var css:String = ""
        css += "Container#sliderListContainer{"
        css +=      "float:left;"
        css +=      "clear:left;"
        css +=      "fill:blue;"
        css +=      "fill-alpha:1;"
        css +=      "padding-left:20px;"
        css +=      "padding-top:20px;"
        //css +=      "margin-left:12px;"
        //css +=      "margin-top:12px;"
        css += "}"
        StyleManager.addStyle(css)
        
        let dp = DataProvider(FileParser.xml("~/Desktop/scrollist.xml"))
        let sliderListContainer:Container = self.addSubView(Container(140, 70, self, "sliderListContainer")) as! Container
        let sliderList:SliderList = sliderListContainer.addSubView(SliderList(140, 96, 24, dp, sliderListContainer)) as! SliderList
        sliderList
        //ListModifier.select(sliderList, "white");
        //		scrollList.setMaxShowingItems(6);
        //		trace("scrollList.list.getSelected(): " + scrollList.list.getSelected());
        //		var index:int = scrollList.list.getSelectedIndex();
        //		trace("selected Title: "+scrollList.list.dataProvider.getItemAt(index).title);
        
        
    }
    func xmlListTest(){
        let path = "~/Desktop/test.xml"
        
        let content = FileParser.content(path.tildePath)
        //Swift.print("content: " + "\(content)")
        
        let xmlDoc:NSXMLDocument = try! NSXMLDocument(XMLString: content!, options: 0)
        let rootElement:NSXMLElement = xmlDoc.rootElement()!
        rootElement
        
        Swift.print("rootElement.children?.count: " + "\(rootElement.children?.count)")
        
        let items = XMLParser.toArray(rootElement)
        Swift.print("items.count: " + "\(items.count)")
        
        //let tempDict:Dictionary<String,String> = ["color":"blue"]
        for item in items{
           DictionaryParser.describe(item)
        }
        
        //continue here: add the code above to the DataProvider init method
        //add a test to the list where you load the data into the list
        //cross of the item in the todo list
        
        
        //Swift.print("rootElement.localName: " + "\(rootElement.localName)")
        //Swift.print("rootElement.childCount: " + "\(rootElement.childCount)")
        
        //let child:NSXMLElement = XMLParser.childAt(rootElement.children!, 0)!
        //Swift.print("child.stringValue: " + "\(child.stringValue)")
        //Swift.print("child.localName: " + "\(child.localName)")
        
        //let svg:SVG = SVGParser.svg(rootElement);
        
        //var xml:XML = FileParser.xml(new File(File.applicationDirectory.url+"assets/xml/list.xml"));
        //var dp:DataProvider = new DataProvider(xml);
    }
    func textButtonTest(){
        
        StyleManager.addStylesByURL("~/Desktop/css/textButton.css")
        //btn = TextButton("",200,200)
        let textButton:TextButton = TextButton("Button",96,24,self)
        
        
        
        self.addSubview(textButton)
        
        
        
    }
    func listTest(){
        StyleManager.addStylesByURL("~/Desktop/css/list.css")
        /*
        let orange:Dictionary<String,String> = ["title":"orange", "property":"harry"]
        let blue = ["title":"blue", "property":"na"]
        let red = ["title":"white", "property":"spring"]//purple,turquoise
        let dp:DataProvider = DataProvider([orange,blue,red])
        */
        let dp = DataProvider(FileParser.xml("~/Desktop/test.xml"))
        
        let section = self.addSubView(Section(200, 200, self, "listSection")) as! Section/*this instance represents the inset shadow bagground and also holds the buttons*/
        let list = section.addSubView(List(140,220,24,dp,section)) as! List

        ListModifier.selectAt(list, 1)/*Selects the second item list*/
        list.dataProvider.addItemAt(["title":"brown"], 0)/*adds a new item at index 0*/
        list.dataProvider.addItem(["title":"pink"])/*adds a new item to the end of the list*/
        list.dataProvider.addItems([["title":"black"], ["title":"orange"]])/*adds 2 items to the end of the list*/
        list.dataProvider.removeItem(list.dataProvider.getItem("brown")!)/*remove the item with title brown*/
        list.dataProvider.removeItemAt(0)/*remove the first item in the list*/
        
        Swift.print("Selected: " + "\(ListParser.selected(list))")/*print the selected item*/
        Swift.print("Selected index: " + "\(ListParser.selectedIndex(list))")/*print the index of the selected item*/
        Swift.print("Selected title: " + "\(ListParser.selectedTitle(list))")/*print the title of the selected item*/
        
        //list.dataProvider.removeAll()/*removes all the items in the list*/
        
       
        //TODO: dont forget you changed the exception thing. May not be of any importance.
        
        //Continue here: fix the resize problem
        
        
    }
    func dataProviderTest(){
        let orange:Dictionary<String,String> = ["name":"orange", "title":"harry"]
        let blue = ["name":"blue", "url":"na"]
        let red = ["name":"red", "headline":"spring"]
        
        let dp:DataProvider = DataProvider()
        func onEvent(event:Event){
            Swift.print("event.type: " + event.type + " origin: " + "\(event.origin)" )
        }
        dp.event = onEvent
        
        dp.addItem(orange)
        dp.addItem(blue)
        dp.addItem(red)
        
        let i = dp.getItemIndex(orange)
        Swift.print("i: " + "\(i)")
        dp.removeItemAt(i)
        
        /**/
        Swift.print(dp.count())
    }
    /**
     *
     */
    func createCheckBoxButton(){
        var css:String = ""
        /*generics*/
        css += "ButtonBase{"
        css +=     "fill:linear-gradient(top,#FFFEFE,#E8E8E8);"
        css += "}"
        css += "ButtonHighlight{"
        css +=     "fill:linear-gradient(top,#BCD5EE 1 0.0087,#BAD4EE 1 0.0371,#B4CEEB 1 0.0473,#A8C4E7 1 0.0546,#98B6E0 1 0.0605,#98B5E0 1 0.0607,#96B4DF 1 0.2707,#8EB0DD 1 0.3632,#81A9DA 1 0.4324,#6EA0D6 1 0.4855,#538ECB 1 0.5087,#8ABBE3 1 0.8283,#A8D6EF 1 1);"
        css += "}"
        css += "InsetShadow{"
        css +=      "drop-shadow:drop-shadow(0px 0 #000000 0.4 4 4 1 2 true);"
        css += "}"
        /*CheckBoxButton*/
        css += "CheckBoxButton{"
        css +=     "float:left;"
        css +=     "clear:none;"
        css +=     "width:72px;"
        css +=     "drop-shadow:none;"
        css +=     "height:14px;"
        css +=     "margin-top:5px;"
        css +=     "padding:0px;"
        css +=     "margin-top:0px;"
        css +=     "margin-left:12px;"
        css += "}"
        css += "CheckBoxButton Text{"
        css +=     "clear:none;"
        css +=     "width:100%;"
        css +=     "font:Lucida Grande;"
        css +=     "size:12px;"
        css +=     "color:grey6;"
        css +=     "autoSize:left;"
        //css +=     "margin-top:0px;"
        css +=     "margin-left:0px;"
        css +=     "height:22px;"
        css +=     "margin-top:-1px;"
        css += "}"
        /*CheckBox*/
        css += "CheckBox{"
        css +=     "fill:<ButtonBase>,~/Desktop/svg/icons/check2.svg grey;"/*use fill-alpha 0,1 instead here*/
        css +=     "fill-alpha:1,0;"
        css +=     "float:left;"
        css +=     "clear:left;"
        css +=     "corner-radius:2px;"//2px
        css +=     "width:13px;"
        css +=     "height:13px;"
        css +=     "padding:0px;"
        css +=     "line:#707070;"//was grey9
        css +=     "line-alpha:1;"
        css +=     "line-thickness:1px;"
        css +=     "line-offset-type:outside;"
        css += "}"
        css += "CheckBox:checked{"
        css +=     "fill:<ButtonHighlight>,~/Desktop/svg/icons/check2.svg black;"
        css +=     "fill-alpha:1,1;"
        css +=     "line:#7692A9;"
        css += "}"
        /**/
        css += "CheckBoxButton CheckBox{"
        css +=    "margin-right:2px;"
        css +=    "margin-left:0px,1px;"
        css +=    "margin-top:0px,1px;"
        css += "}"
        /*Section*/
        //css += "Section#checkBoxButtonContainer{float:left;clear:left;padding-top:20px;padding-left:20px;}"
        /*section*/
        css += "Section#checkBoxButtonContainer{"
        css +=      "corner-radius:4px;"
        css +=      "fill:#EFEFF4;"//bg color for win: #E8E8E8
        css +=      "float:left;"
        css +=      "clear:left;"
        css +=      "width:178px;"//<---temp solution, this should be minus the padding left, test and fix this in a separate test
        css +=      "height:24px;"//<---same goes with this one
        css +=      "padding-left:0px;"
        css +=      "padding-top:0px;"
        css +=      "drop-shadow:<InsetShadow>;"
        css +=      "margin-left:12px;"
        css +=      "margin-top:12px;"
        css += "}"
        StyleManager.addStyle(css)
        
        let container = self.addSubView(Section(200, 200, self, "checkBoxButtonContainer")) as! Section/*this instance represents the inset shadow bagground and also holds the buttons*/
        let checkBoxButton1 = container.addSubView(CheckBoxButton(120, 32,"Option 1",true,container)) as! CheckBoxButton
        let checkBoxButton2 = container.addSubView(CheckBoxButton(120, 32,"Option 2",false,container)) as! CheckBoxButton
        
        let checkGroup = CheckGroup([checkBoxButton1,checkBoxButton2],checkBoxButton1)/*Add the CheckBoxButtons to the checkGroup instance*/
        func onEvent(event:Event){/*this is the event handler*/
            if(event.type == CheckGroupEvent.change){
                Swift.print("CustomView.onCheck() checked" + "\((event as! CheckGroupEvent).checked)")
            }
        }
        checkGroup.event = onEvent/*adds the event handler to the event exit point in the checkGroup*/
    }
    /**
     * TODO: use this for stroke: highlight stroke: 002D4E  use grey for regular stroke
     */
    func createCheckBox(){
        Swift.print("buttonTest()")
        var css:String = "CheckBox{width:25px;height:25px;}"
        /*generics*/
        css += "ButtonBase{"
        css +=     "fill:linear-gradient(top,#FFFEFE,#E8E8E8);"
        css += "}"
        css += "ButtonHighlight{"
        css +=     "fill:linear-gradient(top,#BCD5EE 1 0.0087,#BAD4EE 1 0.0371,#B4CEEB 1 0.0473,#A8C4E7 1 0.0546,#98B6E0 1 0.0605,#98B5E0 1 0.0607,#96B4DF 1 0.2707,#8EB0DD 1 0.3632,#81A9DA 1 0.4324,#6EA0D6 1 0.4855,#538ECB 1 0.5087,#8ABBE3 1 0.8283,#A8D6EF 1 1);"
        css += "}"
        
        /*CheckBox*/
        css += "CheckBox{"
        css +=     "padding:0px;"
        css +=     "fill:<ButtonHighlight>,~/Desktop/svg/icons/check2.svg black;"
        css +=     "fill-alpha:1,1;"
        css +=     "float:left;"
        css +=     "clear:left;"
        css +=     "corner-radius:4px;"//2px
        css +=     "line:#7692A9;"
        css +=     "line-alpha:1;"
        css +=     "line-thickness:1px;"
        css +=     "line-offset-type:outside;"
        css += "}"
        css += "CheckBox:checked{"
        css +=     "fill:<ButtonBase>,~/Desktop/svg/icons/check2.svg grey;"/*use fill-alpha 0,1 instead here*/
        css +=     "line:#707070;"//was grey9
        css +=     "fill-alpha:1,0;"
        css += "}"
        css += "Section#checkBoxContainer{float:left;clear:left;padding-top:20px;padding-left:20px;}"
        StyleManager.addStyle(css)
        
        //try to add the checkbox to the checkboxbutton
        //add two checkboxbutton in a row
        //add the insetshadow in the bg
        //add a slight dropshaodw on the checkboxes, see if you did the same with radiobullets, then copy that. or use subtleshadow or alike
        
        let container = addSubView(Section(200,200,self,"checkBoxContainer")) as! Section
        let checkBox = container.addSubView(CheckBox(25,25,false,container)) as! CheckBox
        
        
        func onEvent(event:Event){
            Swift.print("CustomView.onEvent() type: " + "\(event.type)" + " origin: " + "\(event.origin)" + " immediate: " + "\(event.immediate)")
        }
        
        container.event = onEvent
    }
    /**
     * TODO: Create examples etc
     */
    func createTextInput(){
        var css:String = ""
        /*generics*/
        css += "InsetShadow{"
        css +=      "drop-shadow:drop-shadow(0px 0 #000000 0.4 4 4 1 2 true);"
        css += "}"
        /*Text*/
        css += "Text{"
        css +=     "float:left;"
        css +=     "clear:left;"
        css +=     "font:Lucida Grande;"
        css +=     "size:12px;"
        css +=     "align:left;"
        //css +=     "wordWrap:true;"
        //css +=     "autoSize:none;"
        css +=     "color:grey6;"
        //css +=     "margin-top:4px;"
        css +=     "backgroundColor:orange;"
        css +=     "background:false;"
        css += "}"
        /*TextInput*/
        css += "TextInput{"
        css +=     "padding:0px;"
        css +=     "float:left;"
        css +=     "clear:left;"
        css += "}"
        css += "TextInput Text{"
        css +=     "float:left;"
        css +=     "clear:none;"
        css +=     "width:78px;"
        css +=     "height:22px;"
        css +=     "margin-top:4px;"
        css +=     "color:grey4;"
        css += "}"/**/
        css += "TextInput TextArea{"
        css +=     "clear:none;"
        css +=     "width:60px;"
        css +=     "height:24px;"
        css +=     "padding:0px;"
        css +=     "fill:white;"
        css +=     "line:grey9;"
        css +=     "line-alpha:1;"
        css +=     "line-thickness:1px;"
        css +=     "line-offset-type:outside;"
        css +=     "drop-shadow:<InsetShadow>;"
        css += "}"/**/
        css += "TextInput TextArea Text{"
        css +=     "margin-left:4px;"
        css +=     "padding-right:-20px;"
        css +=     "type:input;"
        css +=     "selectable:true;"
        css += "}"
       
        
        css += "Section#textContainer{fill:green;fill-alpha:0;float:left;clear:left;padding-top:20px;padding-left:20px;corner-radius:0px;}"
        
        
        StyleManager.addStyle(css)
        
        let container = addSubView(Section(200,200,self,"textContainer")) as! Section
        
        let textInput:TextInput = container.addSubView(TextInput(200, 28, "Description: ", "blue", container)) as! TextInput
        textInput
    }
    /**
     *
     */
    func createSingleLineTextArea(){
        var css:String = ""
        /*generics*/
        css += "InsetShadow{"
        css +=      "drop-shadow:drop-shadow(0px 0 #000000 0.4 4 4 1 2 true);"
        css += "}"
      
        /*TextArea*/
        css += "TextArea{"
        css +=     "float:left;"
        css +=     "clear:left;"
        css +=     "width:180px;"
        css +=     "height:24px;"
        css +=     "fill:white;"
        css +=     "line:grey9;"
        css +=     "line-alpha:1;"
        css +=     "line-thickness:1px;"
        css +=     "line-offset-type:outside;"
        css +=     "padding:0px;"
        css +=     "drop-shadow:<InsetShadow>;"
        css += "}"
        css += "TextArea Text{"
        css +=     "width:100%;"
        css +=     "height:24px;"
        css +=     "float:left;"
        css +=     "clear:left;"
        css +=     "font:Lucida Grande;"
        css +=     "size:12px;"
        css +=     "align:left;"
        //css +=     "autoSize:none;"
        css +=     "color:grey6;"
        css +=     "type:input;"
        css +=     "selectable:true;"
        css +=     "wordWrap:true;"
        //css +=     "margin-top:4px;"
        css +=     "backgroundColor:orange;"
        css +=     "background:false;"
        //css +=     "leading:2px;"
        //css +=     "multiline:true;"
        css +=     "margin-top:4px;"
        css +=     "margin-left:6px;"
        css += "}"
        
        css += "Section#textContainer{fill:green;fill-alpha:0;float:left;clear:left;padding-top:20px;padding-left:20px;corner-radius:0px;}"
        
        
        StyleManager.addStyle(css)
        
        let container = Section(200,200,self,"textContainer")
        addSubview(container)
        
        let textArea:TextArea = container.addSubView(TextArea(180, 24, "This is a single line text area", container)) as! TextArea
        textArea
    }
    /**
     *
     */
    func createText(){
        var css:String = ""
        css += "Section#textContainer{fill:white;float:left;clear:left;}"
        css += "Text{"
        css +=     "float:left;"
        css +=     "clear:left;"
        css +=     "font:Lucida Grande;"
        css +=     "size:12px;"
        css +=     "align:left;"
        css +=     "autoSize:none;"
        css +=     "color:grey6;"
        css +=     "type:input;"
        css +=     "selectable:true;"
        css +=     "wordWrap:true;"
        css +=     "margin-top:4px;"
        css +=     "backgroundColor:orange;"
        css +=     "background:false;"
        css += "}"
        StyleManager.addStyle(css)
        
        let container = Section(200,50,self,"textContainer")
        addSubview(container)
        
        let text:Text = container.addSubView(Text(100,24,"This is text: ",container)) as! Text
        text
    }
    /**
     * TODO: create the LeverSpinner component with text
     */
    func createLeverSpinner(){
        var css:String = ""
        /*generics*/
        css += "InsetShadow{"
        css +=      "drop-shadow:drop-shadow(0px 0 #000000 0.4 4 4 1 2 true);"
        css += "}"
        css += "ButtonBase{"
        css +=     "fill:linear-gradient(top,#FFFEFE,#E8E8E8);"
        css += "}"
        /*leverSpinner css*/
        css += "Spinner{"
        css +=      "float:left;"
        css +=      "clear:left;"
        css +=      "width:120px;"
        css +=      "height:24px;"
        css +=      "padding:0px;"
        css += "}"
        /*text css*/
        css += "Spinner TextInput{"
        css +=     "float:left;"
        css +=     "clear:none;"
        css +=     "width:90px;"
        css +=     "height:28px;"
        css +=     "margin-right:6px;"
        //css +=     "margin-top:4px;"
        css += "}"
        css += "Spinner TextInput Text{"
        css +=     "width:40px;"
        css +=     "height:28px;"
        css +=     "font:Lucida Grande;"
        //css +=     "selectable:false;"
        //css +=     "type:dynamic;"
        css +=     "wordWrap:true;"
        css +=     "size:12px;"
        css +=     "color:gray;"
        css +=     "align:left;"
        css +=     "backgroundColor:orange;"
        css +=     "background:false;"
        css +=     "margin-top:2px;"
        css +=     "float:left;"
        css +=     "clear:none;"
        css += "}"
        css += "Spinner TextInput TextArea{"
        css +=     "width:50px;"
        css +=     "height:20px;"
        css +=     "float:left;"
        css +=     "clear:none;"
        css +=     "fill:white;"
        css +=     "fill-alpha:1;"
        css +=     "line:grey9;"
        css +=     "line-alpha:1;"
        css +=     "line-thickness:1px;"
        css +=     "line-offset-type:outside;"
        css +=     "drop-shadow:<InsetShadow>;"
        css += "}"
        css += "Spinner TextInput TextArea Text{"
        css +=     "width:100%;"
        css +=     "align:right;"
        css +=     "selectable:true;"
        css +=     "type:input;"
        //css +=     "mouseEnabled:true;"
        css += "}"
        
        /*stepper css*/
        
        css += "Stepper{"
        css +=    "padding-left:6px;"//<---temp fix
        css +=    "float:left;"
        css +=    "clear:none;"
        css += "}"
        css += "Stepper Button{"
        css +=    "padding-left:0px;"//<---temp fix
        css +=    "float:left;"
        css +=    "width:10px,10px;"
        css +=    "height:10px,10px;"
        css +=    "margin-left:0px,1px;"
        css +=    "fill-alpha:1;"
        css +=    "line:grey7;"
        css +=    "line-offset-type:outside;"
        css +=    "line-alpha:1;"
        css +=    "line-thickness:1px;"
        //css +=    "drop-shadow:<SubtleShadow>,none;"
        css += "}"
        css += "Stepper Button#plus{"
        css +=     "fill:<ButtonBase>,~/Desktop/svg/icons/arrow_up_closed.svg grey8;"//assets/svg/icons/arrow_up_closed.svg
        css +=     "corner-radius:4px 4px 0px 0px;"
        css +=     "margin-top:0px,1px;"
        css += "}"
        css += "Stepper Button#minus{"
        css +=     "clear:left;"
        css +=     "height:10px,10px;"
        css +=     "fill:<ButtonBase>,~/Desktop/svg/icons/arrow_down_closed.svg grey8;"
        css +=     "line-offset-type-top:inside;"
        //css +=     "margin-top:0px;"
        css +=     "corner-radius:0px 0px 4px 4px;"
        css += "}"
        
        css += "Section#container{fill:green;fill-alpha:0;float:left;clear:left;padding-top:20px;padding-left:8px;}"
        StyleManager.addStyle(css)
        
        let container = addSubView(Section(200,200,self,"container")) as! Section
        
        
        
        
        let leverSpinner:LeverSpinner = container.addSubView(LeverSpinner(140, 40,"Value: ", 0, 1, CGFloat(Int.min), CGFloat(Int.max), 0, 100, 200, container)) as! LeverSpinner;
        leverSpinner
        
        
    }
    var stepper:LeverStepper?
    var stepperContainer:Section?
    /**
     * TODO: maybe change the inside to the top not the bottom
     * TODO: add hover and down states in the css
     */
    func createLeverStepper(){
        var css:String = ""
        css += "ButtonBase{"
        css +=     "fill:linear-gradient(top,#FFFEFE,#E8E8E8);"
        css += "}"
        css += "Stepper{"
        css +=    "float:left;"
        css +=    "clear:left;"
        css +=    "padding:0px;"
        css += "}"
        css += "Stepper Button{"
        css +=    "float:left;"
        css +=    "width:10px,10px;"
        css +=    "height:10px,10px;"
        css +=    "margin-left:0px,1px;"
        css +=    "fill-alpha:1;"
        css +=    "line:grey7;"
        css +=    "line-offset-type:outside;"
        css +=    "line-alpha:1;"
        css +=    "line-thickness:1px;"
        //css +=    "drop-shadow:<SubtleShadow>,none;"
        css += "}"
        css += "Stepper Button#plus{"
        css +=     "fill:<ButtonBase>,~/Desktop/svg/icons/arrow_up_closed.svg grey8;"//assets/svg/icons/arrow_up_closed.svg
        css +=     "corner-radius:4px 4px 0px 0px;"
        css +=     "margin-top:0px,1px;"
        css += "}"
        css += "Stepper Button#minus{"
        css +=     "clear:left;"
        css +=     "height:10px,10px;"
        css +=     "fill:<ButtonBase>,~/Desktop/svg/icons/arrow_down_closed.svg grey8;"
        css +=     "line-offset-type-top:inside;"
        //css +=     "margin-top:0px;"
        css +=     "corner-radius:0px 0px 4px 4px;"
        css += "}"
        
        css += "Section#container{fill:green;fill-alpha:0;float:left;clear:left;padding-top:6px;padding-left:28px;}"
        StyleManager.addStyle(css)
        
        stepperContainer = addSubView(Section(200,200,self,"container")) as? Section
        stepper = stepperContainer!.addSubView(LeverStepper(100,24,0,1,CGFloat(Int.min),CGFloat(Int.max),0,100,200,stepperContainer)) as? LeverStepper
        
    }
    
    func buttonTest(){
        Swift.print("buttonTest()")
        var css:String = "Button{width:50px;height:50px;}"
        css += "Button#test{fill:green;float:left;clear:left;corner-radius:5px;}"
        css += "Button#test:over{fill:blue;width:70px;height:70px;}"
        StyleManager.addStyle(css)
        
        
        //let container = Section(500,500,self,"radioBulletContainer")
        //ddSubview(container)
        
        //let box = Element(100,100)
        //addSubview(box)
        
        var testButton:Button = Button(0,0,self,"test")
        addSubview(testButton)
        
        func onEvent(event:Event){
            Swift.print("CustomView.onEvent() type: " + "\(event.type)" + " origin: " + "\(event.origin)")
        }
        
        //add a local listener 
        testButton.event = onEvent
    }
    /*override func hitTest(aPoint: NSPoint) -> NSView? {
    let temp = super.hitTest(aPoint)
    Swift.print("temp: " + "\(NSViewParser.parents(temp!))")
    return temp
    }*/
    /**
     *
     */
    func createRadioBullets(){
        var css:String = ""
        css += "Section#boxContainer{fill:green;float:left;clear:left;padding-top:20px;padding-left:20px;corner-radius:0px;}"
        //css += "Element#box{fill:blue;float:left;clear:left;padding-top:0px;padding-left:0px;}"
        
        /*generics*/
        css += "InsetShadow{"
        css +=      "drop-shadow:drop-shadow(0px 0 #000000 0.4 4 4 1 2 true);"
        css += "}"
        css += "RadioBulletBase{"
        css +=     "fill:linear-gradient(bottom, #EDEDED 1 0,#EDEDED 1 0.4214,#EDEDED 1 0.4908,#F6F6F6 1 0.5605,#FDFDFD 1 0.6768,#FFFFFF 1 1);"
        css += "}"
        css += "RadioBulletBase:selected{"
        css +=    "fill:linear-gradient(bottom, #87C2F3 1 0,#87C2F3 1 0.4214,#87C2F3 1 0.4908,#97CAF4 1 0.5147,#ADD5F6 1 0.5573,#BEDDF7 1 0.6077,#C9E3F8 1 0.67,#D0E6F9 1 0.7574,#D2E7F9 1 1);"
        css += "}"
        css += "RadioBulletTopShine{"
        css +=     "fill:radial-gradient(50% 20% 40% 120% 90 -1, white 1 0,white 0.33 0.4724,white 0 1);"
        css += "}"
        css += "RadioBulletBottomShine{"
        css +=     "fill:radial-gradient(50% 80% 90% 90% 0 0, white 0.70 0,white 0 1);"
        css += "}"
        css += "RadioBulletBulletShine{"
        css +=     "fill:radial-gradient(50% 50% 100% 100% 90 0.2, white 1 0,white 0 0.5);"
        css += "}"
        /*section*/
        css += "Section#radioBulletContainer{"
        css +=      "corner-radius:4px;"
        css +=      "fill:#EFEFF4;"//bg color for win: #E8E8E8
        css +=      "float:left;"
        css +=      "clear:left;"
        css +=      "width:56px;"//<---temp solution, this should be minus the padding left, test and fix this in a separate test
        css +=      "height:24px;"//<---same goes with this one
        css +=      "padding-left:9px;"
        css +=      "padding-top:4px;"
        css +=      "drop-shadow:<InsetShadow>;"
        css +=      "margin-left:8px;"
        css +=      "margin-top:4px;"
        css += "}"
        /*idle*/
        css += "Section#radioBulletContainer RadioBullet{"
        css += "float:left;"
        css += "clear:none;"
        css += "drop-shadow:none;"
        css += "padding-left:0px;"
        css += "padding-top:0px;"
        css += "width:14px,14px,14px,14px,5px;"
        css += "height:14px,14px,14px,14px,5px;"
        css += "margin-right:6px;"
        css += "margin-left:0px,0px,0px,0px,5.5px;"
        css += "margin-top:0px,0px,0px,0px,5.5px;"
        css += "corner-radius:7px,7px,7px,7px,2.5px;"
        css += "line:grey7;"
        css += "line-offset-type:outside,outside,outside,outside;"
        css += "line-alpha:1,0,0,0,0;"
        css += "line-thickness:1px,1px,1px,1px,1px;"
        css += "fill:<RadioBulletBase>,blue,blue,blue,blue;"
        css += "fill-alpha:1,0,0,0,0;"
        css += "}"
        /*selected*/
        css += "Section#radioBulletContainer RadioBullet:selected{"
        css += "fill:<RadioBulletBase:selected>,<RadioBulletBottomShine>,<RadioBulletTopShine>,<RadioBulletBulletShine>,#021931;"
        css += "fill-alpha:1,0,0,0,1;"
        css += "}"
        
        StyleManager.addStyle(css)
        
        let container = Section(500,500,self,"radioBulletContainer")
        addSubview(container)
        
        let radioBullet1 = RadioBullet(14,14,true,container)
        container.addSubview(radioBullet1)
        
        let radioBullet2 = RadioBullet(14,14,false,container)
        container.addSubview(radioBullet2)
        radioBullet2.setSelected(false)//<---work around for now
        
        let selectGroup = SelectGroup([radioBullet1,radioBullet2],radioBullet1)/**/
        
        func onSelect(event:Event){
            if(event.type == SelectGroupEvent.change){
                Swift.print("CustomView.onSelect selected" + "\((event as! SelectGroupEvent).selected)")
            }
        }
        selectGroup.event = onSelect
    }
    
    /**
     * Adds close button, min, max
     */
    func createTitleBar(){
        //Swift.print("CustomView.createTitleBar()")
        StyleManager.addStylesByURL("~/Desktop/css/titleBar.css")
        section = self.addSubView(Section(frame.width,16,self,"titleBar")) as? Section
        closeButton = section!.addSubView(Button(0,0,section!,"close")) as? Button/*<--TODO: the w and h should be NaN, test if it supports this*/
        minimizeButton = section!.addSubView(Button(0,0,section!,"minimize")) as? Button
        maximizeButton = section!.addSubView(Button(0,0,section!,"maximize")) as? Button
    }
    /**
     *
     */
    override func setSize(width:CGFloat,_ height:CGFloat){
        //Swift.print("CustomView.setSize() size: " + "\(size)")
        //self.skin!.setSize(size.width, size.height)
        super.setSize(width, height)
        section!.setSize(width, section!.height)
    }
    /**
     *
     */
    func onCloseButtonReleaseInside() {
        Swift.print("onCloseButtonReleaseInside")
        //Close window here
        //self.window?.close()//this closes the window
        NSApp.terminate(self)//quits the app
    }
    /**
     *
     */
    func onMinimizeButtonReleaseInside(){
        Swift.print("onMinimizeButtonReleaseInside")
        //minimize the window here
        
        //NSApp.miniaturizeAll(self)//minimizes all windows in the app
        self.window?.miniaturize(self)
    }
    /**
     * TODO: Add support for fullscreen mode aswell: window.setFrame(NSScreen.mainScreen()!.visibleFrame, display: true, animate: true)
     * TODO: add support for zooming back to normal size
     */
    func onMaximizeButtonReleaseInside(){
        Swift.print("onMaximizeButtonReleaseInside")
        //maximize the window here
        self.window?.zoom(self)
    }
    /**
     *
     */
    func onTestButtonDown(){
        Swift.print("onTestButtonDown")
    }
    /**
     *
     */
    override func onEvent(event: Event) {
        //Swift.print( "CustomView.onEvent() event:" + "\(event)")
        /*if(event.origin === stepper && event.type == StepperEvent.change){
        //Swift.print("onStepperEvent() value: " + "\((event as! StepperEvent).value)")
        }*/
        
        
        //Swift.print("CustomView.onEvent: " + "\(event)" + " event.origin: " + "\(event.origin)")
        if(event.origin === closeButton && event.type == ButtonEvent.upInside){onCloseButtonReleaseInside()}
        else if(event.origin === minimizeButton && event.type == ButtonEvent.upInside){onMinimizeButtonReleaseInside()}
        else if(event.origin === maximizeButton && event.type == ButtonEvent.upInside){onMaximizeButtonReleaseInside()}
        //else if(event.origin === testButton && event.type == ButtonEvent.down){onTestButtonDown()}
        /*Event listeners:*/
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "onCloseButtonReleaseInside:", name: ButtonEvent.releaseInside, object: closeButton)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMinimizeButtonReleaseInside:", name: ButtonEvent.releaseInside, object: minimizeButton)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMaximizeButtonReleaseInside:", name: ButtonEvent.releaseInside, object: maximizeButton)
    }
}