import Foundation

class TestView8 :CustomView {
    override func resolveSkin() {
        super.resolveSkin()
        StyleManager.addStylesByURL("~/Desktop/css/del.css")
        addSubView(Element(100,100,self,"box"))
    }
}

//continue here: get correct width from parent when parent has padding both left and right. When child is 100% in width
