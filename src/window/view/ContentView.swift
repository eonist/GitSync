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
    override func onEvent(event: Event) {
        if(event.type == ListEvent.select){
            Swift.print("ContentView select")
            RepoData.sharedInstance.selectedIndex = (event as! ListEvent).index
            repoView!.removeFromSuperview()
            repoDetailView = addSubView(repoDetailView ?? RepoDetailView(width,height,self))
        }else if(event.type == ButtonEvent.upInside && event.origin === repoDetailView!.backButton){
            repoDetailView!.removeFromSuperview()
            repoView = addSubView(repoView ?? RepoView(width,height,self))
        }
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