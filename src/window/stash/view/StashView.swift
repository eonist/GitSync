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
        StyleManager.addStyle("Section#titleBar{padding-top:16px;padding-left:12px;}")
        
        section = leftSideBar!.addSubView(Section(75,16,leftSideBar,"titleBar")) as? Section
        closeButton = section!.addSubView(Button(0,0,section!,"close")) as? Button/*<--TODO: the w and h should be NaN, test if it supports this*/
        minimizeButton = section!.addSubView(Button(0,0,section!,"minimize")) as? Button
        maximizeButton = section!.addSubView(Button(0,0,section!,"maximize")) as? Button
    }
    override func createTitleBar() {
    }
}

//import the stylekit logo

class LeftSideBar:Element{
    static let w:CGFloat = 75
    override func resolveSkin() {
        var css = "LeftSideBar{float:left;clear:left;}"
        css += "Section#buttonSection {padding-top:16px;padding-left:12px;}"
        css += "Section#buttonSection Button{fill-alpha:0.2;float:left;clear:left;margin-top:12px;margin-left:16px;padding:0px;}"
        //css += "Section#buttonSection Button#avatar{fill-alpha:1;fill:~/Desktop/svg_icons/avatar.svg none;margin-left:0px;margin-top:0px;}"
        css += "Section#buttonSection Button#inbox{fill:~/Desktop/svg_icons/inbox.svg white;fill-alpha:0.6;}"
        css += "Section#buttonSection Button#home{fill:~/Desktop/svg_icons/home.svg white;}"
        css += "Section#buttonSection Button#pics{fill:~/Desktop/svg_icons/pics.svg white;}"
        css += "Section#buttonSection Button#camera{fill:~/Desktop/svg_icons/camera.svg white;}"
        css += "Section#buttonSection Button#game{fill:~/Desktop/svg_icons/game.svg white;}"
        css += "Section#buttonSection Button#view{fill:~/Desktop/svg_icons/view.svg white;}"
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
        //buttonSection.addSubView(Button(50,50,buttonSection,"avatar")) as! Button
        let btn1 = buttonSection.addSubView(SelectButton(20,20,buttonSection,"inbox")) as! SelectButton
        let btn2 = buttonSection.addSubView(SelectButton(20,20,buttonSection,"home")) as! SelectButton
        let btn3 = buttonSection.addSubView(SelectButton(20,20,buttonSection,"pics")) as! SelectButton
        let btn4 = buttonSection.addSubView(SelectButton(20,20,buttonSection,"camera")) as! SelectButton
        let btn5 = buttonSection.addSubView(SelectButton(20,20,buttonSection,"game")) as! SelectButton
        let btn6 = buttonSection.addSubView(SelectButton(20,20,buttonSection,"view")) as! SelectButton
        
        let selectGroup = SelectGroup([btn1,btn2,btn3,btn4/**/],btn1);
        selectGroup
    }
    
}
class MainContent:Element{
    //var background:IElement?
    /**
     * Draws the graphics
     */
    override func resolveSkin() {
        let css = "MainContent{fill:#EFEFF4;fill-alpha:1;float:left;clear:none;corner-radius:0px 6px 0px 6px;}"
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


