import Cocoa
//white background
//svg icon test
//setup views leftSideBarView and MainContentView

class StashView:CustomView {
    
    var leftSideBar:LeftSideBar?
    override func resolveSkin() {
        var css = ""//E8E8E8
        css += "Window Element#background{fill:#EFEFF4;fill-alpha:0;}"//<--you should target a bg element not the window it self, since now everything inherits these values
        StyleManager.addStyle(css)
        super.resolveSkin()
        Swift.print("Hello world")
        leftSideBar = addSubView(LeftSideBar(LeftSideBar.w,height,self)) as? LeftSideBar
        createCustomTitleBar()
        leftSideBar!.createButtons()
        addSubView(MainContent(frame.width-LeftSideBar.w,frame.height,self))
    }
    func createCustomTitleBar() {
        StyleManager.addStylesByURL("~/Desktop/css/titleBar.css")
        StyleManager.addStyle("Section#titleBar{padding-top:16px;padding-left:0px;padding-right:0px;}")
        
        section = leftSideBar!.addSubView(Section(75,16,leftSideBar,"titleBar")) as? Section
        closeButton = section!.addSubView(Button(0,0,section!,"close")) as? Button/*<--TODO: the w and h should be NaN, test if it supports this*/
        minimizeButton = section!.addSubView(Button(0,0,section!,"minimize")) as? Button
        maximizeButton = section!.addSubView(Button(0,0,section!,"maximize")) as? Button
    }
    override func createTitleBar() {
    }
}
class LeftSideBar:Element{
    static let w:CGFloat = 75
    override func resolveSkin() {
        var css = "LeftSideBar{float:left;clear:left;padding-left:12px;padding-right:-12px;}"
        css += "Section#buttonSection Button#pics{fill-alpha:0.4;float:left;clear:left;margin-top:24px;margin-left:8px;}"
        css += "Section#buttonSection Button#pics{fill:~/Desktop/svg_icons/pics.svg white;fill-alpha:0.4;float:left;clear:left;margin-top:24px;margin-left:8px;}"
        css += "Section#buttonSection Button#camera{fill:~/Desktop/svg_icons/camera.svg white;fill-alpha:0.4;float:left;clear:left;margin-top:24px;margin-left:8px;}"
        StyleManager.addStyle(css)
        Swift.print("MainContent.resolveSkin()")
        super.resolveSkin()
        
        
        //background = addSubView(Element(width,height,self,"background")) as? IElement
    }
    /**
     *
     */
    func createButtons(){
        let buttonSection = self.addSubView(Section(75,200,self,"buttonSection")) as! Section
        buttonSection.addSubView(Button(35,35,buttonSection,"pics")) as! Button
        buttonSection.addSubView(Button(35,35,buttonSection,"camera")) as! Button
    }
    
}
class MainContent:Element{
    //var background:IElement?
    /**
     * Draws the graphics
     */
    override func resolveSkin() {
        let css = "MainContent{fill:#EFEFF4;fill-alpha:1;float:left;clear:none;corner-radius:0px 4px 0px 4px;}"
        StyleManager.addStyle(css)
        Swift.print("MainContent.resolveSkin()")
        super.resolveSkin()
        //background = addSubView(Element(width,height,self,"background")) as? IElement
    }

    override func setSize(width: CGFloat, _ height: CGFloat) {
        super.setSize(width, height)
        //background?.setSize(width, height)
    }
}


