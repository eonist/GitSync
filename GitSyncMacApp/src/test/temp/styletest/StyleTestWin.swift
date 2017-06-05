import Cocoa
@testable import Element
@testable import Utils

class StyleTestWin:Window {
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
        self.minSize = CGSize(300,350)
        self.maxSize = CGSize(500,700)
    }
    override func resolveSkin() {
        self.contentView = StyleTestView(frame.size.width,frame.size.height)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class StyleTestView:CustomView{
    var main:Section?
    override func resolveSkin(){
        Swift.print("StyleTestView")
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/styletest.css")
        
        var css:String = ""
        css += "#main{width:100%;height:100%;fill:silver;fill-alpha:0;padding:0px;min-width:300px;max-width:500px;min-height:350px;max-height:700;}"
        css += "#content{fill:yellow;width:calc(100% -80px);height:100%;float:left;}"
        //"#btn{fill:blue;width:100%;height:50;float:left;clear:left;}"//calc(100% -20px)
        
        StyleManager.addStyle(css)
        StyleManager.addStyle("~/Desktop/ElCapitan/basic/window/titlebar.css")
        super.resolveSkin()
        //self.window?.title = "StyleTest"
        
        main = self.addSubView(Section(NaN,NaN,self,"main"))
        let leftbar = main?.addSubView(LeftSideBar(NaN,NaN,main,"leftBar"))
        _ = leftbar
        
        let content = main?.addSubView(Section(NaN,NaN,main,"content"))
        _ = content
        //let btn = section!.addSubView(Element(NaN,NaN,section,"btn"))
        //_ = btn
        
        
        //main ✅
            //all UI
        //leftBar ✅
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
class LeftSideBar:Element{
    override func resolveSkin() {
        var css:String = ""
        css += "#leftBar{fill:orange;fill-alpha:0;width:80px;height:100%;float:left;}"
        css += "#buttonSection {"
        css +=     "width:100%;"
        css +=     "height:100%;"
        css +=     "padding-top:16px;"
        css +=     "padding-left:28px;"
        css += "}"
        css += "#buttonSection SelectButton{"
        css +=     "fill:green;"
        css +=     "fill-alpha:0.3;"
        css +=     "width:24;"
        css +=     "height:24;"
        css +=     "float:left;"
        css +=     "clear:left;"
        css +=     "margin-bottom:12px;"
        css += "}"
        css += "#buttonSection SelectButton:selected{"
        css +=      "fill-alpha:0.6;"
        css += "}"
        StyleManager.addStyle(css)
        super.resolveSkin()
        createButtons()
    }
    func createButtons(){
        let buttonSection = self.addSubView(Section(NaN,NaN,self,"buttonSection"))
        let buttonTitles = ["commits","repos","settings"]
        var buttons:[ISelectable] = []
        for buttonTitle in buttonTitles{
            buttons.append(buttonSection.addSubView(SelectButton(20,20,true,buttonSection,buttonTitle)))
        }
        let selectGroup = SelectGroup(buttons,buttons[0]);
        func onSelect(event:Event){
            //do something here
        }
        selectGroup.event = onSelect
    }
}
