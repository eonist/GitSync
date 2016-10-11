import Foundation

class RepoView:Element {
    var treeList:TreeList?
    override func resolveSkin() {
        Swift.print("RepoView.resolveSkin()")
        super.resolveSkin()
        let xml:NSXMLElement = FileParser.xml("~/Desktop/repo2.xml".tildePath)
        treeList = addSubView(TreeList(width, height-24, NaN, Node(xml), self))
        
        let someNaN:Any?
        someNaN = Int.NaN
        someNaN = UInt.NaN
        someNaN = CGFloat.NaN
        someNaN = Double.NaN
        someNaN = Float.NaN
        
    }
}