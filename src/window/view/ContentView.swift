import Foundation

class ContentView:Element{
    var repoView:RepoView?
    override func resolveSkin() {
        StyleManager.addStyle("ContentView{float:left;clear:none;/*fill:orange;*/}")
        super.resolveSkin()
        repoView = addSubView(RepoView(width,height,self))
    }
}