import Cocoa

class StashView:CustomView {

    override func resolveSkin() {
        var css = ""//E8E8E8
        css += "Window Element#background{fill:#EFEFF4;fill-alpha:0;corner-radius:4px;}"//<--you should target a bg element not the window it self, since now everything inherits these values
        css += "Window MainContent{fill:blue;fill-alpha:1;float:left;clear:left;}"
        StyleManager.addStyle(css)
        super.resolveSkin()
        Swift.print("Hello world")
        addSubView(MainContent(100,100,self))
        
    }
}

private class MainContent:Element{
    //var background:IElement?
    /**
     * Draws the graphics
     */
    override func resolveSkin() {
        super.resolveSkin()
        //background = addSubView(Element(width,height,self,"background")) as? IElement
    }

    override func setSize(width: CGFloat, _ height: CGFloat) {
        super.setSize(width, height)
        //background?.setSize(width, height)
    }
}
