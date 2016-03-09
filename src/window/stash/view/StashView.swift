import Cocoa

class StashView:CustomView {

    override func resolveSkin() {
        var css = ""//E8E8E8
        css += "Window Element#background{fill:#EFEFF4;fill-alpha:0;corner-radius:4px;}"//<--you should target a bg element not the window it self, since now everything inherits these values
        StyleManager.addStyle(css)
        super.resolveSkin()
        Swift.print("Hello world")
        addSubView(MainContent(100,100,self))
        
    }
}

class MainContent:Element{
    //var background:IElement?
    /**
     * Draws the graphics
     */
    override func resolveSkin() {
        let css = "MainContent{fill:blue;fill-alpha:1;float:right;clear:right;corner-radius:8px;}"
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
