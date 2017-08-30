import Foundation

import Foundation
@testable import Utils
@testable import Element

class LeftSideBar:Element{
    var menuContainer:MenuContainer?
    var isLeftBarHidden:Bool = false
    override func resolveSkin() {
        super.resolveSkin()
        self.menuContainer = self.addSubView(MenuContainer.init(id:"buttonSection"))
        _ = self.addSubView(Element.init(id:"ruler"))
    }
}
