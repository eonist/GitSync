import Foundation

class RepoView:Element {
    var treeList:TreeList?
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        //StyleManager.addStyle("RepoView{padding-top:8px;}")//padding-left:6px;padding-right:6px;
        super.resolveSkin()
        let xml:NSXMLElement = FileParser.xml("~/Desktop/repo2.xml".tildePath)
        treeList = addSubView(TreeList(width, height-24, NaN, Node(xml), self))
    }
}