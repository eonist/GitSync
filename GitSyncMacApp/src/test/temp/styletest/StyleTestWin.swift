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
    var main:Section?
    override func resolveSkin(){
        Swift.print("StyleTestView")
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/styletest.css")
        
        var css:String = ""
        css += "#main{width:100%;height:100%;fill:silver;padding:0px;min-width:200px;max-width:500px;min-height:300px;max-height:600;}"
        css += "#leftBar{fill:blue;width:80px;height:100%;float:left;}"
        //"#btn{fill:blue;width:100%;height:50;float:left;clear:left;}"//calc(100% -20px)
        
        StyleManager.addStyle(css)
        
        super.resolveSkin()
        //self.window?.title = "StyleTest"
        
        main = self.addSubView(Section(NaN,NaN,self,"main"))
        let leftbar = main?.addSubView(Section(NaN,NaN,main,"leftBar"))
        _ = leftbar
        
        let leftbar = main?.addSubView(Section(NaN,NaN,main,"leftBar"))
        _ = leftbar
        //let btn = section!.addSubView(Element(NaN,NaN,section,"btn"))
        //_ = btn
        
        
        //main
            //all UI
        //leftBar
            //topBar
                //titleBtns
            //menu
        //CommitsView
            //List
        //RepoView
            //List
        //RepoDetail
            //TextInput's
        //PrefsView
            //TextInput's
    }
    /**
     * NOTE: gets calls from Window.didResize
     */
    override func setSize(_ width:CGFloat,_ height:CGFloat){
        super.setSize(width, height)
        Swift.print("StyleTestView.setSize w:\(width) h:\(height)")
        ElementModifier.refreshSize(main!)
    }
}
