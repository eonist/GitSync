import Cocoa
@testable import Utils
@testable import Element

class StyleTestView:CustomView{
    var main:Section?
    static var content:Section?
    static var currentView:Element?
    static var leftbar:LeftSideBar?
    
    override func resolveSkin(){
        Swift.print("StyleTestView")
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/styletest.css")//StyleManager.addStylesByURL("~/Desktop/ElCapitan/styletest.css")
        
        var css:String = ""
        
        css += "#main{width:100%;height:100%;fill:silver;fill-alpha:0;padding:0px;min-width:300px;max-width:500px;min-height:350px;max-height:700;}"
        css += "#content{fill:white;fill-alpha:1;width:calc(100% -80px);height:100%;float:left;}"
        //css += "Section#commit{fill:white;width:100%;height:100%;}"
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
