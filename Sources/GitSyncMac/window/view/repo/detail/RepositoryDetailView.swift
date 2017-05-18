import Foundation
@testable import Utils
@testable import Element

class RepositoryDetailView:Element {
    lazy var text1:Element = {return self.addSubView(Element(NaN,self.height,self,"text1"))}()
    lazy var text2:Element = {return self.addSubView(Element(NaN,self.height,self,"text2"))}()
    override func resolveSkin() {
        var css:String = "RepositoryDetailView{float:left;clear:left;}"
        css += "RepositoryDetailView #left{fill:orange;width:100%;float:left;clear:none;}"
        css += "RepositoryDetailView #right{fill:green;width:100%;float:left;clear:none;}"
        StyleManager.addStyle(css)
        super.resolveSkin()
        _ = leftColumn
        _ = rightColumn
    }
}
