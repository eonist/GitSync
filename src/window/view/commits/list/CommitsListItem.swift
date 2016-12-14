import Foundation
/**
 * NOTE: repo-name,contributor,title,description,date
 */
class CommitsListItem:Button,ISelectable{
    var repoName:String
    var contributor:String
    var title:String
    var desc:String/*Description*/
    var date:String
    var isSelected:Bool
    var titleText:Text?
    var repoNameText:Text?
    var contributorText:Text?
    var descText:Text?
    var dateText:Text?
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
        let container = addSubView(Section(width,100,self,"textContainer"))
        repoNameText = container.addSubView(Text(120,20,repoName,container,"repoName"))
        repoNameText!.isInteractive = false
        contributorText = container.addSubView(Text(100,20,contributor,container,"contributor"))
        contributorText!.isInteractive = false
        
        titleText = container.addSubView(Text(320,24,title,container,"title"))
        titleText!.isInteractive = false
        descText = container.addSubView(Text(180,50,desc,container,"description"))
        descText!.isInteractive = false
        
        dateText = container.addSubView(Text(180,24,date,container,"date"))
        dateText!.isInteractive = false
    }
    override func mouseUpInside(event: MouseEvent) {
        isSelected = true
        super.mouseUpInside(event)
        self.event!(SelectEvent(SelectEvent.select,self/*,self*/))
    }
    /**
     * Sets data to the UI elements
     */
    func setData(data:Dictionary<String,String>){
        titleText!.setText(data["title"]!)
        repoNameText!.setText(data["repo-name"]!)
        contributorText!.setText(data["contributor"]!)
        descText!.setText(data["description"]!)
        dateText!.setText(data["date"]!)
    }
    /**
     * @Note: do not add a dispatch event here, that is the responsibilyy of the caller
     */
    func setSelected(isSelected:Bool){
        self.isSelected = isSelected
        setSkinState(getSkinState())
    }
    func getSelected() -> Bool {
        return self.isSelected
    }
    override func setSkinState(skinState:String) {
        //Swift.print("\(self.dynamicType)" + " setSkinState() skinState: " + "\(skinState)")
        super.setSkinState(skinState)
        titleText!.setSkinState(skinState)
    }
    override func getSkinState() -> String {
        return isSelected ? SkinStates.selected + " " + super.getSkinState() : super.getSkinState();
    }
    override func getClassType() -> String {
        return String(CommitsListItem)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}



//<commit repo-name="Element" contributor="Eonist" title="Comment update" description="Updated a comment in the file: View.swift" date="2016-01-22"/>

//repo-name
//contributor
//title
//description
//date