import Foundation

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
        let container = addSubView(Section(width,50,self,"textContainer")) 
        let headerText:Text = container.addSubView(Text(120,20,header,container,"header"))
        headerText.isInteractive = false
        let dateText:Text = container.addSubView(Text(100,20,date,container,"date"))
        dateText.isInteractive = false
        let titleText:Text = container.addSubView(Text(180,24,title,container,"title"))
        titleText.isInteractive = false
        let contentText:Text = container.addSubView(Text(180,152,content,container,"content"))
        contentText.isInteractive = false
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