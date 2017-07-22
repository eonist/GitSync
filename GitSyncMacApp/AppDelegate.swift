import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac

/**
 * This is the main class for the application
 * Not one error in a million keystrokes
 */
@NSApplicationMain
class AppDelegate:NSObject, NSApplicationDelegate {
    weak var window:NSWindow!
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    var menu:Menu?//TODO: ⚠️️ make lazy. does it need to be scoped globally?
    
    func applicationDidFinishLaunching(_ aNotification:Notification) {
        Swift.print("GitSync - Automates git")//Simple git automation for macOS, The autonomouse git client,The future is automated
        //jsonTest()
        
        //initApp()
        //stateTest()
        //themeSwitchTest()
        //testGraphXTest()
        //testGraphView2()
        
        
        //targetAnimationTest()
        //horizontalListTest()
        
        
    }
    /**
     *
     */
    func animator2Test(){
        //Setup a window
        window.size = CGSize(664,400)
        window.contentView = InteractiveView2()
        window.title = ""
        
        //Continue here: 🏀
            //just code the bellow up and test 🏖
        
        /*
        let anim1 = Animator2(initValues:Animator2.initValues){ value in
            Swift.print("value: " + "\(value)")
            //onFrame anim here, move X forward
            //starts the animation
        }.wait(duration:2){//pauses the anim for a little bit
            //give the user some time to think
        }
        let anim2 = Animator2(initValues:Animator2.initValues) { value in//adds a new anim block to the completed callBack
            Swift.print("value: " + "\(value)")
            //onFrame anim here, rotate 360deg , this animation is repeated 3 times
        }.pause { animRef in
            bg.async{
                //do heavy calculations
                main.async{
                    animRef.continue()//start the anim again
                }
            }
        }.onComplete {//this is the final complete call in the chain
            Swift.print("anim chain completed")
        }
        anim1.onComplete{
            anim2.start()//start the second anim right after the first started
        }
         
        anim1.start()//initiates the animation chain
         
         //remember this needs to support many different animators and also simultan animations, so it cant be too intertwined
        
        */
        
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
        let animator = PointSpringer(progress, PointSpringer.initValues,PointSpringer.initConfig)/*Setup interuptable animator*/
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
    func initApp(){
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        let themeStr:String = PrefsView.prefs.darkMode ? "dark.css" : "light.css"
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/styletest/" + themeStr,true)
        
        //StyleWatcher.watch("~/Desktop/ElCapitan/","~/Desktop/ElCapitan/gitsync.css", self.win!.contentView!)
        let rect:CGRect = PrefsView.prefs.rect
        win = StyleTestWin(rect.w, rect.h)/*⬅️️🚪*/
        menu = Menu()/*This creates the App menu*/
    }
    
    func applicationWillTerminate(_ aNotification:Notification) {
        _ = FileModifier.write(Config.prefs.tildePath, PrefsView.xml.xmlString)/*Stores the app prefs*/
        Swift.print("💾 Write PrefsView to: prefs.xml")
        _ = FileModifier.write(Config.repoListFilePath.tildePath, RepoView.treeDP.tree.xml.xmlString)/*store the repo xml*/
        Swift.print("💾 Write RepoList to: repo.xml")
        print("Good-bye")
    }
}

/*
func themeSwitchTest(){
    
    //Continue here: 🏀
    //deprecated the last of gitsync old css files ✅
    //setup the themes for styleTest 👈
    //You then store the colors in light and dark theme ✅
    //then hook up the switch to the css switcher code ✅
    //COntinue here:
    
    window.contentView = InteractiveView2()
    
    StyleManager.addStylesByURL("~/Desktop/theme/lighttheme.css")
    
    let section = window.contentView!.addSubView(Section(200,300))
    let btn = section.addSubView(Button(NaN,NaN,section,"btn"))
    _ = section.addSubView(Element(100,100,section,"one"))
    
    btn.event = { event in
        if event.type == ButtonEvent.upInside {
            Swift.print("value: " + "\(StyleManager.getStylePropVal("Theme", "fill"))")//white
            StyleManager.reset()
            StyleManager.addStylesByURL("~/Desktop/theme/darktheme.css")
            ElementModifier.refreshSkin(section)
            Swift.print("newVal: " + "\(StyleManager.getStylePropVal("Theme", "fill")))")//black
        }
    }
}
func stateTest(){
    window.contentView = InteractiveView2()
    var css:String = "#btn{fill:blue;width:100px;height:24px;float:left;clear:left;}"
    css += "#green{fill:green;clear:left;float:left;display:block;}"
    css += "#green:hidden{fill:orange;display:none;}"
    StyleManager.addStyle(css)
    
    let section = window.contentView!.addSubView(Section(200,300))
    let btn = section.addSubView(Button(NaN,NaN,section,"btn"))
    
    let one = section.addSubView(Element(100,100,section,"green"))
    btn.event = { event in
        if event.type == ButtonEvent.upInside {
            Swift.print("test")
            one.setSkinState("hidden")
        }
    }
}
*/
/*
func jsonTest(){
    Swift.print("jsonTest")
    /*JSONParser.dictArr("[{\"title\":\"doctor\"}]".json)?.forEach{
     Swift.print("\(JSONParser.dict($0)?["title"])")//doctor
     }*/
    //let content = "~/Desktop/gitsync.json".content
    //Swift.print("content: " + "\(content)")
    //let json = "~/Desktop/gitsync.json".content!.json
    //Swift.print("json: " + "\(json)")
    //let dict = JSONParser.dict("~/Desktop/gitsync.json".content?.json)
    //Swift.print("dict: " + "\(dict)")
    
    StyleManager.addStylesByURL("~/Desktop/ElCapitan/styletest.css")
    JSONParser.dictArr(JSONParser.dict("~/Desktop/gitsync.json".content?.json)?["repoDetailView"])?.forEach{
        if let element:IElement = UnFoldUtils.unFold($0) {
            Swift.print("created an element")
            _ = element
        }else{
            Swift.print("did not create an element")
        }
    }
}*/
//paddingTest()
//calcTest()
/*
 func initTestWin(){
 //StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css",false)
 StyleManager.addStylesByURL("~/Desktop/ElCapitan/test.css",false)
 win = TestWin(500,400)/*Debugging Different List components*/
 
 /*fileWatcher =*/
 //StyleWatcher.watch("~/Desktop/ElCapitan/","~/Desktop/ElCapitan/gitsync.css", self.win!.contentView!)
 }
 
 
 func initMinimalWin(){
 NSApp.windows[0].close()
 StyleManager.addStylesByURL("~/Desktop/ElCapitan/minimal.css",true)
 //Swift.print("StyleManager.styles.count: " + "\(StyleManager.styles.count)")
 //Swift.print("StyleManager.styles: " + "\(StyleManager.styles)")
 win = MinimalWin(500,400)
 }
 
 */
/*class Label:Flexible{
    //graphic bg
    //text that is centeres
    //implement Flexible
    // that also repos the text etc
    lazy var txtBtn:NSView = {
        let textButton:TextButton = TextButton.init(self.w, self.h, self.title, nil)
        return textButton
    }()
    init(_ rect:CGRect){
        
    }
}*/

/*
/**
 *
 */
func calcTest(){
    window.contentView = InteractiveView2()
    var css:String = "#btn{fill:blue;width:calc(100% -20px);height:50;float:left;clear:left;}"
    css += "Section{fill:silver;padding:12px;}"
    StyleManager.addStyle(css)
    
    let section = window.contentView!.addSubView(Section(200,200))
    let btn = section.addSubView(Element(NaN,NaN,section,"btn"))
    
    section.addSubview(btn)
}
func paddingTest(){
    window.contentView = InteractiveView2()
    var css:String = "#btn{fill:blue;width:100%;height:100%;float:left;clear:left;}"
    css += "Section{fill:silver;padding:12px;}"
    StyleManager.addStyle(css)
    
    let section = window.contentView!.addSubView(Section(200,300))
    let btn = section.addSubView(Element(NaN,NaN,section,"btn"))
    
    section.addSubview(btn)
}
 */
/**
 *
 */
/*
func hitTesting(){
    window.contentView = InteractiveView2()
    StyleManager.addStyle("Button{fill:blue;}")
    
    let btn = Button(50,50)
    let container = window.contentView!.addSubView(Container(0,0,nil))
    
    container.addSubview(btn)
    /*container.layer?.position.x = 100
     container.layer?.position.y = 100*/
    container.layer?.position = CGPoint(40,20)
    //container.frame.origin = CGPoint(100,100)
    Swift.print("container.layer?.position: " + "\(container.layer?.position)")
    Swift.print("container.frame.origin: " + "\(container.frame.origin)")
    
    btn.layer?.position = CGPoint(40,20)
    //btn.frame
    Swift.print("btn.layer?.position: " + "\(btn.layer?.position)")
    Swift.print("btn.frame.origin: " + "\(btn.frame.origin)")
    btn.event = { event in
        if(event.type == ButtonEvent.upInside){Swift.print("hello world")}
    }
}
 */
