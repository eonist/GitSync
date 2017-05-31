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
    var section:Section?
    override func resolveSkin(){
        Swift.print("StyleTestView")
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/styletest.css")
        
        var css:String = "#btn{fill:blue;width:100%;height:50;float:left;clear:left;}"//calc(100% -20px)
        css += "Section{width:100%;height:100%;fill:silver;padding:12px;min-width:200px;}"
        StyleManager.addStyle(css)
        
        super.resolveSkin()
        //self.window?.title = "StyleTest"
        
        
        section = self.addSubView(Section(NaN,NaN,self))
        let btn = section!.addSubView(Element(NaN,NaN,section,"btn"))
        _ = btn
        //topBar
            //titleBtns
            //menu
        //main
            //leftBar
        
        //CommitsView
            //left view
        //RepoView
            //left view
        //StatsView
            //no bars
        //PrefsView
            //no bars
    }
    /**
     * NOTE: gets calls from Window.didResize
     */
    override func setSize(_ width:CGFloat,_ height:CGFloat){
        super.setSize(width, height)
        Swift.print("StyleTestView.setSize w:\(width) h:\(height)")
        ElementModifier.refreshSize(section!)
    }
}
