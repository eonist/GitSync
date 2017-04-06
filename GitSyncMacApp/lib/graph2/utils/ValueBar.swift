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
        let strings:[String] = GraphUtils.verticalIndicators(Graph9.config.valueBarCount, 1.0)
        let itemYSpace:CGFloat = (height-100)/4
        var y:CGFloat = 50
        strings.forEach{ str in
            let textArea:TextArea = TextArea(NaN,NaN,str,self/*leftBar!*/)
            items.append(self.addSubView(textArea))
            textArea.setPosition(CGPoint(0,y))
            y += itemYSpace
        }
    }
    /*func createOldLeftBar(){
        let ySpace:CGFloat = height/8
        let textValues:[String] = (0...8).reversed().map { ($0 * 50).int.string }//"400","350","300"..."0"
        for i in (0...8){
            //let x:CGFloat = 0
            Swift.print("i: " + "\(i)")
            let textValue:String = textValues[i]
            let y:CGFloat = ySpace * i
            let textArea:TextArea = TextArea(NaN,NaN,textValue,self)
            _ = self.addSubView(textArea)
            textArea.setPosition(CGPoint(0,y))
        }
    }*/
}
