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
        Swift.print("GitSync - Automates git")
        initApp()

//        fastList()
//        viewTests()
    }
    
    /**
     *
     */
    func viewTests(){
        setup()
        let view = ViewTest.init(size: CGSize(200,200))
        _ = window.contentView?.addSubView(view)
    }
    func fastList(){
        setup()
        let dp:DataProvider = DataProvider("~/Desktop/assets/xml/longlist.xml".tildePath)
        let section = window.contentView?.addSubView(Section(size:CGSize(200,200)))
//        let config =  List5.Config
        let list = ElasticSliderScrollerFastList5.init(config:.init(itemSize: CGSize(140,24), dp: dp, dir: .ver), size: CGSize(140,73))//FastList5,ScrollerFastList5,SliderScrollerFastList5,ElasticScrollList5,ElasticSliderScrollerList5,SliderScrollerList5
        section?.addSubview(list)
        //list.selectAt(1)
    }
    
    func setup(){
        window.contentView = InteractiveView()
        let styleFilePath:String = Config.Bundle.styles + "styles/styletest/" + "light.css"//"dark.css"
        StyleManager.addStyle(url:styleFilePath,liveEdit: false)
    }
    /**
     * Initializes the app
     */
    func initApp(){
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        NSUserNotificationCenter.default.delegate = self//Enables notifications even when app is in focus
        let themeStr:String = PrefsView.prefs.darkMode ? "dark.css" : "light.css"
        let styleFilePath:String = Config.Bundle.styles + "styles/styletest/" + themeStr
        StyleManager.addStyle(url:styleFilePath,liveEdit: false)
        //StyleWatcher.watch("~/Desktop/ElCapitan/","~/Desktop/ElCapitan/gitsync.css", self.win!.contentView!)
        win = StyleTestWin(PrefsView.prefs.rect.w, PrefsView.prefs.rect.h)
        menu = Menu()/*This creates the App menu*/
    }
    func applicationWillTerminate(_ aNotification:Notification) {
        _ = FileModifier.write(Config.Bundle.prefsURL.tildePath, PrefsData.xml.xmlString)/*Stores the app prefs*/
        Swift.print("💾 Write PrefsView to: prefs.xml")
        _ = FileModifier.write(Config.Bundle.repo.tildePath, RepoView.treeDP.tree.xml.xmlString)/*store the repo xml*/
        Swift.print("💾 Write RepoList to: repo.xml")
        print("Good-bye")
    }
}
extension AppDelegate:NSUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
}



class ViewTest:ScrollerView5{
    override var contentSize: CGSize {return CGSize(super.width*2,super.height*2)}
    override func resolveSkin() {
        StyleManager.addStyle("ViewTest{fill:green;fill-alpha:1.0;}")
        super.resolveSkin()
        createEllipse()
    }
}
/**
 * Testing multiple views performance 👷🚧
 */
extension ViewTest{
    /**
     * Creates debug ellipse
     */
    func createEllipse(){
        /*Styles*/
        let gradient = LinearGradient(Gradients.blue(),[],π/2)
        let lineGradient = LinearGradient(Gradients.deepPurple(0.5),[],π/2)
        let fill:GradientFillStyle = GradientFillStyle(gradient);
        let lineStyle = LineStyle(20,NSColorParser.nsColor(Colors.green()).alpha(0.5),CGLineCap.round)
        let line = GradientLineStyle(lineGradient,lineStyle)
        /*size*/
        let objSize:CGSize = CGSize(200,200)
        Swift.print("objSize: " + "\(objSize)")
        let viewSize:CGSize = CGSize(width,height)
        Swift.print("viewSize: " + "\(viewSize)")
        let p = Align.alignmentPoint(objSize, viewSize, Alignment.centerCenter, Alignment.centerCenter,CGPoint())
        Swift.print("p: " + "\(p)")
        /*Graphics*/
        let ellipse = EllipseGraphic(p.x,p.y,200,200,fill.mix(Gradients.green()),line.mix(Gradients.lightGreen(0.5)))
        contentContainer.addSubview(ellipse.graphic)
        ellipse.draw()
    }
    /**
     * creates many shapes for performance testing
     * //TODO: ⚠️️ Try to draw the same amount of rects but as Shapes not NSViews, maybe via svg or manually
     */
    func createmanyShapes(){
        /*Styles*/
        let colorFill = FillStyle(.green)
        /*size*/
        let objSize:CGSize = CGSize(200,200)
        let viewSize:CGSize = CGSize(width,height)
        let p = Align.alignmentPoint(objSize, viewSize, Alignment.centerCenter, Alignment.centerCenter,CGPoint())
        let rectContainer:NSView = contentContainer.addSubView(Container(200,200))
        rectContainer.frame.origin = p
        
        let hCount:Int = 10
        let vCount:Int = 10
        (0..<hCount).indices.forEach{ i in
            (0..<vCount).indices.forEach{ e in
                let x:CGFloat = /*p.x + */(20 * i)
                let y:CGFloat = /*p.y + */(20 * e)
                let rect = RectGraphic(x,y,10,10,colorFill,nil)
                rectContainer.addSubview(rect.graphic)
                rect.draw()
            }
        }
    }
}

