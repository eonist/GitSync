import Foundation
@testable import Element
@testable import Utils
class ValueBar:Element{
    var items:[TextArea] = []
    override func resolveSkin() {
        addStyles()
        super.resolveSkin()
        createItems()
    }
    /**
     * Creates the Text items that represents data in the y-axis
     */
    func createItems(){
        /*leftBar = addSubView(Section(NaN,newSize!.height,self,"leftBar"))//create left bar
         leftBar!.setPosition(CGPoint(0,newPosition!.y))*/
        let strings:[String] = GraphUtils.verticalIndicators(Graph9.config.vCount, 1.0)
        let itemYSpace:CGFloat = (height-100)/4
        var y:CGFloat = 50
        strings.forEach{ str in
            let textArea:TextArea = TextArea(NaN,NaN,str,self/*leftBar!*/)
            items.append(self.addSubView(textArea))
            textArea.setPosition(CGPoint(0,y))
            y += itemYSpace
        }
    }
}
