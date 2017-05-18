import Foundation
@testable import Element
@testable import Utils

class RepositoryView:Element{
    lazy var leftColumn:Element = {return self.addSubView(Element(NaN,self.height,self,"left"))}()
    lazy var rightColumn:Element = {return self.addSubView(Element(NaN,self.height,self,"right"))}()
    override func resolveSkin() {
        var css:String = "RepositoryView{float:left;clear:left;}"
        css += "RepositoryView #left{fill:blue;width:200px;float:left;clear:none;}"
        css += "RepositoryView #right{fill:red;width:100%;float:left;clear:none;}"
        StyleManager.addStyle(css)
        super.resolveSkin()
        _ = leftColumn
        _ = rightColumn
    }
}
