import Foundation
@testable import Utils
@testable import Element

class LeftSideBar:Element{
    var menuContainer:MenuContainer?
    override func resolveSkin() {
        var css:String = ""
        css += "#leftBar{fill:orange;fill-alpha:1;width:80px;height:100%;float:left;padding-top:0px;}"
        
        StyleManager.addStyle(css)
        super.resolveSkin()
        self.menuContainer = self.addSubView(MenuContainer(NaN,NaN,self,"buttonSection"))
        
        
        
    }
}
