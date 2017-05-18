import Foundation
@testable import Element
@testable import Utils

class RepositoryView:Element{
    lazy var leftColumn:Element = {return self.addSubView(Element(NaN,self.height,self,"left"))}()
    lazy var detailView:RepositoryDetailView = {
        return self.addSubView(RepositoryDetailView(NaN,self.height,self))//self.addSubView(Section(NaN,self.height,self,"right"))
    }()
    override func resolveSkin() {
        var css:String = "RepositoryView{float:left;clear:left;}"
        css += "RepositoryView #left{fill:blue;width:200px;float:left;clear:none;}"
        css += "RepositoryView RepositoryDetailView{fill:red;width:100%;padding-right:-300px;float:left;clear:none;}"
        StyleManager.addStyle(css)
        super.resolveSkin()
        _ = leftColumn
        _ = detailView
    }
}
