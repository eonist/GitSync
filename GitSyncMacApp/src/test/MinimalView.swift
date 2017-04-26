import Foundation
@testable import Element
@testable import Utils

class MinimalView:WindowView{
    override func resolveSkin(){
        let css:String = "Window{fill-alpha:1;fill:white;corner-radius:4px;}"//
        StyleManager.addStyle(css)
        super.resolveSkin()
        rotationUITest()
    }
    func rotationUITest(){
        let css = "Button#test{fill:blue;transform:rotation:(45deg);}"
        StyleManager.addStyle(css)
        let btn = addSubView(Button(20,20,self,"test"))
        _ = btn
    }
    func treeList(){
        let dp:TreeDP2 = TreeDP2("~/Desktop/assets/xml/treelist.xml".tildePath)
        _ = self.addSubView(TreeList3(140, 145, CGSize(24,24), dp, self))
    }
}
