import Foundation
@testable import Element
@testable import Utils
class ValueBar:Element{
    override func resolveSkin() {
        addStyles()
        super.resolveSkin()
        //400
        //8
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
    }
    /**
     * Creates the Text items that represents data in the y-axis
     */
    func createLeftBar(){
        /*    leftBar = addSubView(Section(NaN,newSize!.height,self,"leftBar"))//create left bar
         leftBar!.setPosition(CGPoint(0,newPosition!.y))*/
        
        let strings:[String] = GraphUtils.verticalIndicators(6/*vCount*/, 60/*maxValue!*/)
        
        var y:CGFloat = height/8/*itemYSpace!*/
        strings.forEach{
            let textArea:TextArea = TextArea(NaN,NaN,$0,self/*leftBar!*/)
            /*leftBarItems*///self.append(textArea)
            _ = /*leftBar!*/self.addSubView(textArea)
            textArea.setPosition(CGPoint(0,y))
            y += itemYSpace!
        }
    }
}
