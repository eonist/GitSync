import Foundation
@testable import Element
@testable import Utils

class MinimalView:WindowView{
    override func resolveSkin(){
        //let css:String = "Window{fill-alpha:1;fill:white;corner-radius:4px;}"//
        //StyleManager.addStyle(css)
        super.resolveSkin()
        //rotationUITest()
        checkBoxTest()
    }
    //Continue here: 
        //try using checkboxbutton on the bellow:
    func rotationUITest(){
        var css = "Button{"
        css += "fill:blue,~/Desktop/ElCapitan/svg/arrow_right.svg grey6;"
        css += "transform:rotate(0deg),rotate(0deg);"
        css += "}"
        css += "Button:over{"
        css += "transform:rotate(0deg),rotate(90deg);"
        css += "}"
        StyleManager.addStyle(css)
        let btn = addSubView(Button(100,100,self))
        _ = btn
    }
    /**
     *
     */
    func checkBoxTest(){
        var css = "CheckBox{"
        css += "fill:blue,~/Desktop/ElCapitan/svg/arrow_right.svg grey6;"
        css += "transform:rotate(0deg),rotate(0deg);"
        css += "}"
        css += "CheckBox:checked{"
        css += "transform:rotate(0deg),rotate(90deg);"
        css += "}"
        StyleManager.addStyle(css)
        let checkBox1 = self.addSubView(CheckBox(100,100,false,self))
        _ = checkBox1
    }
    func treeList(){
        let dp:TreeDP2 = TreeDP2("~/Desktop/assets/xml/treelist.xml".tildePath)
        _ = self.addSubView(TreeList3(140, 145, CGSize(24,24), dp, self))
    }
}
