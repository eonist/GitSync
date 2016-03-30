import Foundation

class ActivityListItem:Button,ISelectable{
    var repoName:String
    var contributor:String
    var title:String
    var desc:String/*Description*/
    var date:String
    var isSelected:Bool;
    init(_ width:CGFloat, _ height:CGFloat, _ repoName:String,_ contributor:String,_ title:String,_ desc:String,_ date:String,_ isSelected : Bool = false, _ parent:IElement? = nil, _ id:String? = nil){
        self.repoName = repoName
        self.contributor = contributor
        self.title = title
        self.desc = desc
        self.date = date
        self.isSelected = isSelected
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        let container = addSubView(Section(width,50,self,"textContainer"))
        let repoNameText:Text = container.addSubView(Text(120,20,repoName,container,"repoName"))
        repoNameText.isInteractive = false
        let contributorText:Text = container.addSubView(Text(100,20,contributor,container,"contributor"))
        contributorText.isInteractive = false
        let titleText:Text = container.addSubView(Text(180,24,title,container,"title"))
        titleText.isInteractive = false
        /*let descText:Text = container.addSubView(Text(180,24,desc,container,"description"))
        descText.isInteractive = false
        let dateText:Text = container.addSubView(Text(180,24,date,container,"date"))
        dateText.isInteractive = false
        */
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
        return String(ActivityListItem)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


//<commit repo-name="Element" contributor="Eonist" title="Comment update" description="Updated a comment in the file: View.swift" date="2016-01-22"/>

//repo-name
//contributor
//title
//description
//date