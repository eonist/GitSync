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
        let box = addSubView(Element(40,40,self,"box")) as? IElement
        box
        createArticleItem()
    }
    /**
    *
    */
    func createArticleItem(){
        var css:String = ""
        css += "Section#textContainer{fill:white;float:left;clear:left;fill-alpha:0;}"
        css += "Text{"
        css +=     "float:left;"
        css +=     "clear:left;"
        css +=     "font:Lucida Grande;"
        css +=     "size:12px;"
        css +=     "align:left;"
        css +=     "autoSize:none;"
        css +=     "color:grey6;"
        css +=     "type:input;"
        css +=     "selectable:true;"
        css +=     "wordWrap:true;"
        css +=     "margin-top:4px;"
        css +=     "backgroundColor:orange;"
        css +=     "background:false;"
        css += "}"
        StyleManager.addStyle(css)
        
        let container = Section(200,50,self,"textContainer")
        addSubview(container)
        //let textString:String = "Test something fun this is the tech behind this years revolution in computer technology. Internet continues to widen as the spread for A.I is heading twords it's end"
        let header:Text = container.addSubView(Text(120,24,"Header goes here",container)) as! Text
        header
        let date:Text = container.addSubView(Text(120,24,"Header goes here",container)) as! Text
        date
    }
    override func setSize(width: CGFloat, _ height: CGFloat) {
        super.setSize(width, height)
        //background?.setSize(width, height)
    }
}

//continue here: Add headerText,dateText,contentText store it as a ArticleItem






