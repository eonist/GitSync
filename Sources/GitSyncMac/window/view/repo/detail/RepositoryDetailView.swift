import Foundation
@testable import Utils
@testable import Element

class RepositoryDetailView:Element {
    lazy var text1:Element = {return self.addSubView(Element(NaN,NaN,self,"text1"))}()
    lazy var text2:Element = {return self.addSubView(Element(NaN,NaN,self,"text2"))}()
    lazy var nameTextInput:TextInput = {return self.addSubView(TextInput(self.width, 32, "Name: ", "", self))}()
    override func resolveSkin() {
        var css:String = "RepositoryDetailView{float:left;clear:left;}"
        css += "RepositoryDetailView #text1{fill:orange;width:100%;height:48px;float:left;clear:left;}"
        css += "RepositoryDetailView #text2{fill:green;width:100%;height:48px;float:left;clear:left;}"
        css += "RepositoryDetailView TextInput{width:100%;height:48px;float:left;clear:left;}"
        StyleManager.addStyle(css)
        super.resolveSkin()
        _ = text1
        _ = text2
        _ = nameTextInput
    }
}
