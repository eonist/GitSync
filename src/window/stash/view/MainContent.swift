import Foundation

class MainContent:Element{
    var background:IElement?
    /**
     * Draws the graphics
     */
    override func resolveSkin() {
        StyleManager.addStylesByURL("~/Desktop/css/mainContent.css")
        super.resolveSkin()
        background = addSubView(Element(width,height,self,"background")) as? IElement
        createList()
    }
    func createList(){
        StyleManager.addStylesByURL("~/Desktop/css/articleList.css")
        StyleManager.addStylesByURL("~/Desktop/css/slider.css")
        StyleManager.addStylesByURL("~/Desktop/css/sliderList.css")
        let dp = DataProvider(FileParser.xml("~/Desktop/scrollist.xml"))
        let list = self.addSubView(ArticleList(width,400,98,dp,self,"articleList")) as? ArticleList
        list
    }
    override func setSize(width: CGFloat, _ height: CGFloat) {
        super.setSize(width, height)
        //background?.setSize(width, height)
    }
}