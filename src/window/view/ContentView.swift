import Foundation

class ContentView:Element{
    var repoView:RepoView?
    var repoDetailView:RepoDetailView?
    
    override func resolveSkin() {
        StyleManager.addStyle("ContentView{fill:white;fill-alpha:0;float:left;clear:none;corner-radius:0px 6px 0px 6px;}")/**/
        super.resolveSkin()
        repoView = addSubView(RepoView(width,height,self))
        RepoData.sharedInstance.repoView = repoView
    }
    /**
     *
     */
    func onListItemSelect(event:ListEvent){
        Swift.print("ContentView select")
        RepoData.sharedInstance.selectedIndex = event.index
        Swift.print("RepoData.sharedInstance.selectedIndex: " + "\(RepoData.sharedInstance.selectedIndex)")
        repoView!.removeFromSuperview()
        repoDetailView = addSubView(repoDetailView ?? RepoDetailView(width,height,self))
        let repoData = RepoData.sharedInstance
        let repoItem = repoData.dp.getItemAt(repoData.selectedIndex!)!
        repoDetailView!.setRepoData(repoItem)//updates the UI elements with the selected repo data
    }
    /**
     *
     */
    func onTreeListSelect(event: SelectEvent) {//add local event handler
        Swift.print("ContentView.onTreeListSelect()")
        let selectedIndex:Array<Int> = TreeListParser.selectedIndex(repoView!.treeList!)
        Swift.print("selectedIndex: " + "\(selectedIndex)")
        //print("_scrollTreeList.database.xml.toXMLString(): " + _scrollTreeList.database.xml.toXMLString());
        let selectedXML:NSXMLElement = XMLParser.childAt(repoView!.treeList!.node.xml, selectedIndex)!
        //print("selectedXML: " + selectedXML);
        Swift.print("selectedXML.toXMLString():")
        Swift.print(selectedXML)//EXAMPLE output: <item title="Ginger"></item>
        
        let dict = XMLParser.attribs(selectedXML)
        Swift.print("dict: " + "\(dict)")
        //Swift.print("dict[0]: " + "\(dict[0])")
        
        RepoData.sharedInstance.index = selectedIndex
        Swift.print("RepoData.sharedInstance.selectedIndex: " + "\(RepoData.sharedInstance.selectedIndex)")
        repoView!.removeFromSuperview()
        repoDetailView = addSubView(repoDetailView ?? RepoDetailView(width,height,self))
        //let repoData = RepoData.sharedInstance
        let repoItem = dict//repoData.dp.getItemAt(repoData.selectedIndex!)!
        repoDetailView!.setRepoData(repoItem)//updates the UI elements with the selected repo data
        
        
    }
    /**
     *
     */
    func onRemoveButtonClick(){
        Swift.print("removeButton.click")
        //remove detail view
        //repoView!.list!.dataProvider.removeItemAt(0)//use selected index here
        //add repoView
    }
    /**
     *
     */
    func onBackButtonClick(){
        repoDetailView!.removeFromSuperview()
        repoView = addSubView(repoView ?? RepoView(width,height,self))
    }
    override func onEvent(event: Event) {
        if(event.type == SelectEvent.select && event.immediate === repoView){onTreeListSelect(event as! SelectEvent)}//on list select
        else if(event.type == ButtonEvent.upInside && event.origin === repoDetailView?.topBar!.backButton){onBackButtonClick()}//on back button
        else if(event.type == ButtonEvent.upInside && event.origin === repoDetailView?.topBar!.removeButton){onRemoveButtonClick()}//on remove button
    }
}
/**
 * Stores centtralized data
 */
class RepoData {
    var dp:DataProvider {return repoView!.list!.dataProvider}
    var node:Node {return repoView!.treeList!.node}
    var repoView:RepoView?
    var selectedIndex:Int?
    var index:Array<Int>?
    static var sharedInstance = RepoData()
    private init() {
        //let xml = FileParser.xml("~/Desktop/repo.xml")
        //dp = DataProvider(xml)
    }
}