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
        createList()
        //createArticleItem()
    }
    /**
     *
     */
    func createList(){
        StyleManager.addStylesByURL("~/Desktop/css/articleList.css")
        //StyleManager.addStylesByURL("~/Desktop/css/slider.css")
        //StyleManager.addStylesByURL("~/Desktop/css/sliderList.css")
        
        let dp = DataProvider(FileParser.xml("~/Desktop/scrollist.xml"))
        let section = self.addSubView(Section(200, 200, self, "listSection")) as! Section/*adds some visual space around the component*/
        let list = section.addSubView(ArticleList(140,120,24,dp,section)) as? ArticleList
        list
    }
    /**
    *
    */
    func createArticleItem(){
        
        let container = Section(width,50,self,"textContainer")
        addSubview(container)
        
        let header:Text = container.addSubView(Text(120,20,"Google",container,"header")) as! Text
        header
        let date:Text = container.addSubView(Text(100,20,"24 June 2016",container,"date")) as! Text
        date
        let title:Text = container.addSubView(Text(180,24,"Neural Network",container,"title")) as! Text
        title
        let textString:String = "This is the tech behind this years revolution in computer..."
        let content:Text = container.addSubView(Text(200,152,textString,container,"content")) as! Text
        content
    }
    override func setSize(width: CGFloat, _ height: CGFloat) {
        super.setSize(width, height)
        //background?.setSize(width, height)
    }
}

class ArticleList:List{
    override func mergeAt(objects: [Dictionary<String, String>], _ index: Int) {
        var i:Int = index;
        Swift.print("mergeAt: index: " + "\(index)");
        for object:Dictionary<String,String> in objects {// :TODO: use for i
            let item:SelectTextButton = SelectTextButton(getWidth(), self.itemHeight ,object["title"]!, false, self.lableContainer)
            //Swift.print("item: " + "\(item)")
            self.lableContainer!.addSubviewAt(item, i)/*the first index is reserved for the List skin, what?*/
            i++
        }
    }
}

class 

