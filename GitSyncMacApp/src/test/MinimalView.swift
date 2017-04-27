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
    
    //continue here:
        //load svg
        //try to not reload svg on mouse over
    
    func rotationUITest(){
        var css = "Button{"
        css += "fill:blue,~/Desktop/ElCapitan/svg/arrow_right.svg grey6;"
        css += "fill-alpha:1,1;"
        css += "transform:rotate(0deg);"
        css += "}"
        css += "Button:over{"
        css += "transform:rotate(45deg);"
        css += "}"
        /*fill:blue;fill-alpha:1;transform:rotate(0deg);}*/
        //css += "Button:over{transform:rotate(45deg);}"
        StyleManager.addStyle(css)
        /*let style = StyleManager.getStyle("Button")
         style?.describe()*/
        let btn = addSubView(Button(100,100,self))
        
        _ = btn
    }
    func treeList(){
        let dp:TreeDP2 = TreeDP2("~/Desktop/assets/xml/treelist.xml".tildePath)
        _ = self.addSubView(TreeList3(140, 145, CGSize(24,24), dp, self))
    }
}
