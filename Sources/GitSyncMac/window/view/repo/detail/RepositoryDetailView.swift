import Foundation
@testable import Utils
@testable import Element

class RepositoryDetailView:Element {
    lazy var text1:Element = {return self.addSubView(Element(NaN,self.height,self,"text1"))}()
    lazy var text2:Element = {return self.addSubView(Element(NaN,self.height,self,"text2"))}()
    override func resolveSkin() {
        var css:String = "RepositoryDetailView{float:left;clear:left;}"
        css += "RepositoryDetailView #text1{fill:orange;width:100%;float:left;clear:clear;}"
        css += "RepositoryDetailView #text2{fill:green;width:100%;float:left;clear:clear;}"
        StyleManager.addStyle(css)
        super.resolveSkin()
        _ = leftColumn
        _ = rightColumn
    }
}
