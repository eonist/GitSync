import Foundation

//Load all the xml items

//try to load a list with just the titles first
//Create RepoListItem
//Create RepoList
//Hock up the add and remove functionality
//adding a repo-item shows a InputModalView with the repo-URL,name,branch,etc
//removing a repo-item just removes the item from the List
//save to xml after each remove and add and each repo-settings-update
class RepoView:Element{
    var topBar:TopBar?
    var list:List?
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        super.resolveSkin()
        topBar = addSubView(TopBar(width,48,self))
        
        
        let dp:DataProvider = DataProvider()
        dp.addItems([["title":"brown"],["title":"pink"],["title":"purple"]])
        list = addSubView(List(width, height-48, NaN, dp, self))
        ListModifier.selectAt(list!, 1)
    }
    override func onEvent(event: Event) {
        if(event.type == ButtonEvent.upInside && event.origin === topBar!.addButton){
            Swift.print("addButton.click")
            list!.dataProvider.addItemAt(["title":"blue"], 0)
        }else if(event.type == ButtonEvent.upInside && event.origin === topBar!.removeButton){
            Swift.print("removeButton.click")
            list!.dataProvider.removeItemAt(0)//use selected index here
        }
    }
}
class TopBar:Element{
    var addButton:Button?
    var removeButton:Button?
    override func resolveSkin() {
        StyleManager.addStyle("TopBar{fill:grey;float:left;clear:left;corner-radius:0px 4px 0px 0px;}")
        super.resolveSkin()
        //add buttons here
        StyleManager.addStyle("Button#add{fill:green;float:left;clear:none;line:none;corner-radius:0px;line-thickness:0px;}")
        StyleManager.addStyle("Button#remove{fill:red;float:left;clear:none;line:none;corner-radius:0px;line-thickness:0px;}")
        addButton = addSubView(Button(48,48,self,"add"))
        removeButton = addSubView(Button(48,48,self,"remove"))
        
        
        //hoock up the buttons to eventHandlers
        //add the list 
        //try adding and removing items
        
        
    }
    
}

class RepoList:List{
    override func mergeAt(objects: [Dictionary<String, String>], _ index: Int) {
        var i:Int = index;
        //Swift.print("mergeAt: index: " + "\(index)");
        for object:Dictionary<String,String> in objects {// :TODO: use for i
            let item:RepoListItem = RepoListItem(getWidth(), self.itemHeight, object, false, self.lableContainer)
            self.lableContainer!.addSubviewAt(item, i)/*the first index is reserved for the List skin, what?*/
            i++
        }
    }
    override func getClassType() -> String {
        return String(List)
    }
}





class RepoListItem:Button,ISelectable{
    var item:Dictionary<String,String>
    var isSelected:Bool;
    init(_ width:CGFloat, _ height:CGFloat, _ item:Dictionary<String,String>, _ isSelected : Bool = false, _ parent:IElement? = nil, _ id:String? = nil){
        //Swift.print("RepoListItem init()")
        self.item = item
        self.isSelected = isSelected
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        let container = addSubView(Section(width,48,self,"textContainer"))
        let nameText:Text = container.addSubView(Text(120,20,item["name"]!,container,"name"))
        nameText.isInteractive = false
        let branchText:Text = container.addSubView(Text(100,20,item["branch"]!,container,"branch"))
        branchText.isInteractive = false
        
        
        container
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
        return String(RepoListItem)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}