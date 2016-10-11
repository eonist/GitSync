import Foundation

class RepoView:Element {
    var treeList:TreeList?
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        super.resolveSkin()
        let xml:NSXMLElement = FileParser.xml("~/Desktop/repo2.xml")
        treeList = addSubView(TreeList(width, height-24, NaN, Node(xml), self))
    }
}