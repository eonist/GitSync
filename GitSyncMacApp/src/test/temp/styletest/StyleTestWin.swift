import Cocoa
@testable import Element
@testable import Utils

class VibrantWin:TranslucentWin{
    
}

class StyleTestWin:TranslucentWin {
    convenience init(_ w:CGFloat,_ h:CGFloat){
        self.init(contentRect:NSRect(0,0,w,h), styleMask: [.borderless,.resizable], backing:NSBackingStoreType.buffered, defer: false)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
        self.minSize = CGSize(300,350)
        self.maxSize = CGSize(500,700)
        
        let view = StyleTestView(frame.size.width,frame.size.height)//340,(400 + 10)
        self.contentView?.addSubview(view)
        
        
    }
    /*
     required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
     super.init(docWidth, docHeight)
     
     }
     override func resolveSkin() {
     
     }*/
    //required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class StyleTestView:Element{
    var main:Section?
    static var content:Section?
    static var currentView:Element?
    static var leftbar:LeftSideBar?
    
    override func resolveSkin(){
        Swift.print("StyleTestView")
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/styletest.css")//StyleManager.addStylesByURL("~/Desktop/ElCapitan/styletest.css")
        
        var css:String = ""
        css += "Section#titleBar{padding-top:8px;padding-left:14px;}"
        
        css += "#main{width:100%;height:100%;fill:silver;fill-alpha:0;padding:0px;min-width:300px;max-width:500px;min-height:350px;max-height:700;}"
        css += "#content{fill:yellow;width:calc(100% -80px);height:100%;float:left;}"
        css += "Section#commit{fill:green;width:100%;height:100%;}"
        css += "Section#repo{fill:maroon;width:100%;height:100%;}"
        css += "Section#prefs{fill:fuchsia;width:100%;height:100%;}"
        css += "Section#repoDetail{fill:teal;width:100%;height:100%}"
        //"#btn{fill:blue;width:100%;height:50;float:left;clear:left;}"//calc(100% -20px)
        
        StyleManager.addStyle(css)
        super.resolveSkin()
        //self.window?.title = "StyleTest"
        
        main = self.addSubView(Section(NaN,NaN,self,"main"))
        
        StyleTestView.leftbar = main!.addSubView(LeftSideBar(NaN,NaN,main,"leftBar"))
        
        
        StyleTestView.content = main!.addSubView(Section(NaN,NaN,main,"content"))
        
        
        Nav.setView(Views2.main(.commit))
        
        
        //let btn = section!.addSubView(Element(NaN,NaN,section,"btn"))
        //_ = btn
        
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
