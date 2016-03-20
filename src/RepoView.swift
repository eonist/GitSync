import Foundation

class RepoView:Element{
    var topBar:TopBar?
    override func resolveSkin() {
        "corner-radius:0px 4px 0px 0px"
        super.resolveSkin()
        topBar = addSubView(TopBar(width,48,self))
    }
    //topBar with add and remove buttons, use Text buttons at first
    //Load all the xml items
    //contentView
    //try to load a list with just the titles first
    //Create RepoListItem
    //Create RepoList
    //Hock up the add and remove functionality
    //adding a repo-item shows a InputModalView with the repo-URL,name,branch,etc
    //removing a repo-item just removes the item from the List
    //save to xml after each remove and add and each repo-settings-update
}
class TopBar:Element{
    override func resolveSkin() {
        StyleManager.addStyle("TopBar{fill:green;float:left;clear:left;}")
        super.resolveSkin()
        //add buttons here
    }
}