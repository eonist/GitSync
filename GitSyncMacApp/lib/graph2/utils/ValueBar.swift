import Foundation
@testable import Element
@testable import Utils
class ValueBar:Element{
    var items:[TextArea] = []
    override func resolveSkin() {
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync/stats/valuebar.css")
        super.resolveSkin()
        createItems()
    }
    /**
     * Creates the Text items that represents data in the y-axis
     */
    func createItems(){
        let strings:[String] = GraphUtils.verticalIndicators(Graph9.config.vCount, 1.0)
        let itemYSpace:CGFloat = (height-(topMargin+bottomMargin))/(vCount-1)
        var y:CGFloat = 50
        strings.forEach{ str in
            let textArea:TextArea = TextArea(NaN,NaN,str,self/*leftBar!*/)
            items.append(self.addSubView(textArea))
            textArea.setPosition(CGPoint(0,y))
            y += itemYSpace
        }
    }
}
