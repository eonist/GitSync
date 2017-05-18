import Foundation
@testable import Element
@testable import Utils

class RepositoryView:Element{
    lazy var leftColumn:Element = {return self.addSubView(Element(NaN,NaN,self,"left"))}()
    lazy var rightColumn:Element = {return self.addSubView(Element(NaN,NaN,self,"right"))}()
    override func resolveSkin() {
        var css:String = "RepositoryView{float:left;clear:left;}"
        css += "RepositoryView #left{fill:blue;width:100;height:100;float:left;clear:left;}"
        css += "RepositoryView #left{fill:red;width:100;height:100;float:left;clear:left;}"
        StyleManager.addStyle(css)
        super.resolveSkin()
        _ = leftColumn
        _ = rightColumn
    }
}
