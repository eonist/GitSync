import Cocoa
@testable import Element
@testable import Utils

class StyleTestWin:Window {
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
    }
    override func resolveSkin() {
        self.contentView = StyleTestView(frame.size.width,frame.size.height)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class StyleTestView:WindowView{
    override func resolveSkin(){
        Swift.print("StyleTestView")
        var css:String = ""
        
        StyleManager.addStyle(css)
        super.resolveSkin()
        self.window?.title = "StyleTest"
        
    }
    //customMenuBar
    //Enum nav system
    //use nice css colors (4 colors from FlexTest)
    //use win with gd shadow
    
    //4 views:
        //1. commitsView (repoBrowserView,commitListView,commitDetailView)
        //2. repoView (repoBrowserView,repoDetailView)
        //3. statsView (repoBRowserView,statsView)
        //4. prefsView
}
