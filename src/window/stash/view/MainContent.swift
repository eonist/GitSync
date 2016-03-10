import Foundation

class MainContent:Element{
    //var background:IElement?
    /**
     * Draws the graphics
     */
    override func resolveSkin() {
        //let css = "MainContent{fill:#EFEFF4;fill-alpha:1;float:left;clear:none;corner-radius:0px 6px 0px 6px;}"
        StyleManager.addStylesByURL("~/Desktop/css/mainContent.css")
        //StyleManager.addStyle(css)
        Swift.print("MainContent.resolveSkin()")
        super.resolveSkin()
        //background = addSubView(Element(width,height,self,"background")) as? IElement
        let box = addSubView(Element(40,40,self,"box")) as? IElement
        box
    }
    
    override func setSize(width: CGFloat, _ height: CGFloat) {
        super.setSize(width, height)
        //background?.setSize(width, height)
    }
}

//continue here: Add headerText,dateText,contentText store it as a ArticleItem
