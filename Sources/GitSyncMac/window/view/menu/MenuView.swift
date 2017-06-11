import Foundation

import Foundation
@testable import Utils
@testable import Element

class LeftSideBar:Element{
    var menuContainer:MenuContainer?
    override func resolveSkin() {
        
        super.resolveSkin()
        self.menuContainer = self.addSubView(MenuContainer(NaN,NaN,self,"buttonSection"))
        
        
        _ = self.addSubView(Element(NaN, NaN, self, "ruler"))
    }
}
