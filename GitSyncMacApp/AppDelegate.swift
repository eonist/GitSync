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
//        quickTest()
        
        //Continue here: 🏀
            //Let's try and get GraphX into CustomList
            //Then make a demo where FastList is vertical
            //then try GraphX with FastList
        
//      testGraphXTest()
//      horizontalListTest()
//      viewTests()
//        quickTest()
        
       
    }
    /**
     * //Figure out a sceheme to store the repo commit stats in database where its also removable if repos are removed etc. Also filtering repos 👈👈👈
     */
    func quickTest(){
        let commitDb = CommitCountDB()
        
        let id:String = "RepoA"/*repoID*/
        let year:Int = 2015
        let month:Int = 3
        let commitCount:Int = 20
//        let monthVal:CommitCountDB2.Month = [month:commitCount]
//        let yearVal:CommitCountDB2.Year = [year:monthVal]
//        let repoVal:CommitCountDB2.Repo = (repoId:id,year:yearVal)
//        commitDb.repos[repoVal.repoId] = repoVal.year
        
        commitDb.addRepo(repoId: id, date: CommitCountDB.DBDate.init(year:year,month:month), commitCount: commitCount)
        
        Swift.print("commitCountValue: " + "\(commitDb.repos[id]?[year]?[month])")
        
        commitDb.addRepo(repoId: id, date: CommitCountDB.DBDate.init(year:year,month:month), commitCount: 12)
        
        
        Swift.print("commitCountValue: " + "\(commitDb.repos[id]?[year]?[month])")
        
        //DataBase for git commit count
//        let tempA = TempA()
//        tempA.arr["a"] = (id:"blue",value:["a","b"])
//        tempA.arr["a"]?.value[0] = "x"
//        Swift.print(tempA.arr["a"]?.value[0])
    }
    /**
     *
     */
    func viewTests(){
        setup()
        let view = ViewTest.init(size: CGSize(300,300))
        _ = window.contentView?.addSubView(view)
    }
    /**
     * 
     */
    func horizontalListTest(){
//        setup()
        window.contentView = InteractiveView()
        //Create a vertical list
        //color rects as items
        //db should just be 10 random colors
        let dp:DP = DP.init(Array.init(repeating: ["":""], count: 32))
        let listConfig = List5.Config.init(itemSize: CGSize(80,80), dp: dp, dir: .hor)
        let list = CustomList.init(config: listConfig, size: CGSize(350,80))
        window.contentView?.addSubview(list)
    }
    /**
     * Testing the zoomable and bouncing graph
     */
    func testGraphXTest(){
        Swift.print("Hello GraphX")
        
        window.size = CGSize(664,400)
        window.title = ""
        window.contentView = InteractiveView()
        StyleManager.addStyle(url:"~/Desktop/ElCapitan/graphx/graphxtest.css", liveEdit: true)
        
        let winSize:CGSize = WinParser.size(window)
        let graph = window.contentView!.addSubView(GraphX(winSize.w,winSize.h))
        _ = graph
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

class ViewTest:ElasticScrollerView5{//ScrollerView5,ElasticSliderScrollerView5,ScrollerView5,SliderScrollerView5
    override var contentSize: CGSize {return CGSize(super.width*2,super.height*2)}
    override func resolveSkin() {
        StyleManager.addStyle("ContainerView{fill:blue;fill-alpha:0.0;}")
        super.resolveSkin()
        createEllipse()
    }
}
/**
 * Testing multiple views performance 👷🚧
 */
extension ContainerView5{
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
        let ellipse = EllipseGraphic(0,0,200,200,fill.mix(Gradients.green()),line.mix(Gradients.lightGreen(0.5)))
        contentContainer.addSubview(ellipse.graphic)
        ellipse.graphic.layer?.position = p
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
class CustomList:ElasticScrollerFastList5{
    override func createItem(_ index:Int) -> Element {
        let customListItem = CustomListItem.init(size: itemSize)
        contentContainer.addSubview(customListItem)
//        customListItem.setPosition(CGPoint(itemSize.w*index,0))
        return customListItem
    }
    override func reUse(_ listItem:FastListItem) {
        let randCol:NSColor = NSColorParser.randomColor()
        (listItem.item as! CustomListItem).rect?.graphic.fillStyle = FillStyle.init(randCol)
        (listItem.item as! CustomListItem).rect?.graphic.draw()
        listItem.item.layer?.position[dir] = listItem.idx * itemSize[dir]/*position the item*/
    }
}
class CustomListItem:Element{
    var rect:RectGraphic?
    override func resolveSkin() {
        let randCol:NSColor = NSColorParser.randomColor()
//        let x = index * skinSize.w
//        Swift.print("x: " + "\(x)")
        rect = RectGraphic(0,0,skinSize.w,skinSize.h,FillStyle(randCol))
        rect!.draw()
        addSubview(rect!.graphic)
    }
}
