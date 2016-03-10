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
        StyleManager.addStylesByURL("~/Desktop/css/list.css")
        StyleManager.addStylesByURL("~/Desktop/css/slider.css")
        StyleManager.addStylesByURL("~/Desktop/css/sliderList.css")
        
        
        let dp = DataProvider(FileParser.xml("~/Desktop/scrollist.xml"))
        
        let list = self.addSubView(ArticleList(width,400,98,dp,self,"articleList")) as? ArticleList
        list
    }
    /**
    *
    */
    func createArticleItem(){
       
        
        
    }
    override func setSize(width: CGFloat, _ height: CGFloat) {
        super.setSize(width, height)
        //background?.setSize(width, height)
    }
}

class ArticleList:RBSliderList{
    override func mergeAt(objects: [Dictionary<String, String>], _ index: Int) {
        var i:Int = index;
        Swift.print("mergeAt: index: " + "\(index)");
        for object:Dictionary<String,String> in objects {// :TODO: use for i
            let item:ArticleItem = ArticleItem(getWidth(), self.itemHeight ,object["title"]!, "","","", false, self.lableContainer)
            //Swift.print("item: " + "\(item)")
            self.lableContainer!.addSubviewAt(item, i)/*the first index is reserved for the List skin, what?*/
            i++
        }
    }
    override func getClassType() -> String {
        return String(List)
    }
}

class ArticleItem:Button,ISelectable{
    var isSelected:Bool;
    var header:String
    var date:String
    var title:String
    var content:String
    init(_ width:CGFloat, _ height:CGFloat, _ header:String,_ date:String,_ title:String,_ content:String, _ isSelected : Bool = false, _ parent:IElement? = nil, _ id:String? = nil){
        //Swift.print("ArticleItem init()")
        self.header = header
        self.date = date
        self.title = title
        self.content = content
        self.isSelected = isSelected
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        
        let container = Section(width,50,self,"textContainer")
        addSubview(container)
        
        let header:Text = container.addSubView(Text(120,20,"Google",container,"header")) as! Text
        header.isInteractive = false
        let date:Text = container.addSubView(Text(100,20,"24 June 2016",container,"date")) as! Text
        date.isInteractive = false
        let title:Text = container.addSubView(Text(180,24,"Neural Network",container,"title")) as! Text
        title.isInteractive = false
        let textString:String = "This is the tech behind this years revolution in computer..."
        let content:Text = container.addSubView(Text(180,152,textString,container,"content")) as! Text
        content.isInteractive = false
    }
    override func mouseUpInside(event: MouseEvent) {
        isSelected = true
        super.mouseUpInside(event)
        self.event!(SelectEvent(SelectEvent.select,self/*,self*/))
    }
    /**
     * @Note: do not add a dispatch event here, that is the responsibilyy of the caller
     */
    func setSelected(isSelected:Bool){
        self.isSelected = isSelected
        setSkinState(getSkinState());
    }
    override func getSkinState() -> String {
        return isSelected ? SkinStates.selected + " " + super.getSkinState() : super.getSkinState();
    }
    override func getClassType() -> String {
        return String(ArticleItem)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

