import Foundation

class ContentView:Element{
    var repoView:RepoView?
    var repoDetailView:RepoDetailView?
    
    override func resolveSkin() {
        StyleManager.addStyle("ContentView{float:left;clear:none;/*fill:orange;*/}")
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
    func onRemoveButtonClick(){
        Swift.print("removeButton.click")
        //remove detail view
        //repoView!.list!.dataProvider.removeItemAt(0)//use selected index here
        //add repoView
    }
    override func onEvent(event: Event) {
        if(event.type == ListEvent.select){onListItemSelect(event as! ListEvent)}//on list select
        else if(event.type == ButtonEvent.upInside && event.origin === repoDetailView!.topBar!.backButton){//on back button
            repoDetailView!.removeFromSuperview()
            repoView = addSubView(repoView ?? RepoView(width,height,self))
        }else if(event.type == ButtonEvent.upInside && event.origin === repoDetailView!.topBar!.removeButton){onRemoveButtonClick()}//on remove button
    }
}
/**
 * Stores centtralized data
 */
class RepoData {
    var dp:DataProvider {return repoView!.list!.dataProvider}
    var repoView:RepoView?
    var selectedIndex:Int?
    static var sharedInstance = RepoData()
    private init() {
        //let xml = FileParser.xml("~/Desktop/repo.xml")
        //dp = DataProvider(xml)
    }
}