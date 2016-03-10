import Foundation

class MainContent:Element{
    var background:IElement?
    /**
     * Draws the graphics
     */
    override func resolveSkin() {
        
        StyleManager.addStylesByURL("~/Desktop/css/mainContent.css")
        
        Swift.print("MainContent.resolveSkin()")
        super.resolveSkin()
        background = addSubView(Element(width,height,self,"background")) as? IElement
        //let box = addSubView(Element(40,40,self,"box")) as? IElement
        //box
        createArticleItem()
    }
    /**
    *
    */
    func createArticleItem(){
        
        let container = Section(width,50,self,"textContainer")
        addSubview(container)
        //let textString:String = "Test something fun this is the tech behind this years revolution in computer technology. Internet continues to widen as the spread for A.I is heading twords it's end"
        let header:Text = container.addSubView(Text(120,24,"Google",container,"header")) as! Text
        header
        let date:Text = container.addSubView(Text(100,24,"24 June 2016",container,"date")) as! Text
        date
        let title:Text = container.addSubView(Text(180,52,"Neural Network",container,"title")) as! Text
        title
    }
    override func setSize(width: CGFloat, _ height: CGFloat) {
        super.setSize(width, height)
        //background?.setSize(width, height)
    }
}

//continue here: Add headerText,dateText,contentText store it as a ArticleItem






