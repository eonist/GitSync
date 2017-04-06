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
        let margin:CGFloat = Graph9.config.margin.height
        let itemYSpace:CGFloat = (height-(margin * 2))/(Graph9.config.vCount-1).cgFloat
        var y:CGFloat = margin
        strings.forEach{ str in
            let textArea:TextArea = TextArea(NaN,NaN,str,self)
            items.append(self.addSubView(textArea))
            textArea.setPosition(CGPoint(0,y))
            y += itemYSpace
        }
    }
}
