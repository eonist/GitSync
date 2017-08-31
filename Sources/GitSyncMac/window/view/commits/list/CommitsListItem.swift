import Cocoa
@testable import Utils
@testable import Element
/**
 * NOTE: repo-name,contributor,title,description,date
 * TODO: ⚠️️ move lazy creators into extension
 */
class CommitsListItem:Button,Selectable{
    lazy var container = {
        return addSubView(Section(NaN,100,self,"textContainer"))
    }()
    lazy var titleText:Text = {
        let  titleText = container.addSubView(Text(360,24,config.title,container,"title"))
        titleText.isInteractive = false
        return titleText
    }()
    lazy var repoNameText:Text = {
        let repoNameText = container.addSubView(Text(NaN,NaN,config.repoName,container,"repoName"))
        repoNameText.isInteractive = false
        return repoNameText
    }()
    lazy var contributorText:Text = {
        let contributorText = container.addSubView(Text(NaN,NaN,config.contributor,container,"contributor"))
        contributorText.isInteractive = false
        return contributorText
    }()
    lazy var descText:Text = {
        let descText = container.addSubView(Text(NaN,50,config.desc,container,"description"))
        descText.isInteractive = false
        return descText
    }()
    lazy var dateText:Text = {
        let dateText = container.addSubView(Text(180,24,config.date,container,"date"))
        dateText.isInteractive = false
        return dateText
    }()
    typealias Config = (repoName:String,contributor:String,title:String,desc:String,date:String,isSelected : Bool)
    var config:Config
    
    init(config:Config,  size:CGSize ,   id:String? = nil){
        self.config = config
        super.init(size: size, id: id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        _ = repoNameText
        _ = contributorText
        _ = titleText
        _ = descText
        _ = dateText
    }
    override func mouseUpInside(_ event: MouseEvent) {
        config.isSelected = true
        super.mouseUpInside(event)
        self.event!(SelectEvent(SelectEvent.select,self/*,self*/))
    }
    override var skinState:String {
        get {return config.isSelected ? SkinStates.selected + " " + super.skinState : super.skinState}
        set {
            super.skinState = newValue
            titleText.skinState = newValue
        }
    }
    override func getClassType() -> String {
        return "\(CommitsListItem.self)"
    }
    override func setSize(_ width: CGFloat, _ height: CGFloat) {
        Swift.print("CommitsListItem.width: " + "\(width)")
        Swift.print("getWidth(): " + "\(getWidth())")
        super.setSize(width,height)
    }
    /*override func hitTest(_ aPoint: NSPoint) -> NSView? {
        Swift.print("layer!.position: " + "\(layer!.position)")
        let aPoint = aPoint + CGPoint(layer!.position.x,layer!.position.y)
        return super.hitTest(aPoint)
     }*/
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
extension CommitsListItem{
    /**
     * Sets data to the UI elements
     */
    func setData(_ data:[String:String]){
        titleText.setText(data[CommitType.title.rawValue]!)
        repoNameText.setText(data[CommitType.repoName.rawValue]!)
        contributorText.setText(data[CommitType.contributor.rawValue]!)
        let descStr:String = {
            let str = data[CommitType.description.rawValue]!
            if str.isEmpty {return "There is no description for this commit"}
            else {return str}
        }()
        descText.setText(descStr)
        let date:Date = GitDateUtils.date(data[CommitType.date.rawValue]!)
        //Swift.print("date.shortDate: " + "\(date.shortDate)")
        let relativeTime:(value:Int,type:String) = DateParser.relativeTime(Date(),date)[0]
        let relativeDate:String = relativeTime.value.string + relativeTime.type/*create date like 3s,4m,5h,6w,2y*/
        dateText.setText(relativeDate)
    }
    /**
     * NOTE: do not add a dispatch event here, that is the responsibilyy of the caller
     */
    func setSelected(_ isSelected:Bool){
        Swift.print("setSelected(): " + "\(isSelected)")
        self.config.isSelected = isSelected
        skinState = {skinState}()
    }
    func getSelected() -> Bool {
        return self.config.isSelected
    }
}
//<commit repo-name="Element" contributor="Eonist" title="Comment update" description="Updated a comment in the file: View.swift" date="2016-01-22"/>

enum CommitType:String{//TODO: ⚠️️ move to its own file
    case repoName = "repo-name"
    case contributor = "contributor"
    case title = "title"
    case description = "description"
    case date = "gitDate"
}
