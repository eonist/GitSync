import Foundation
@testable import Element
@testable import Utils

class TimeBar:Element {
    override func resolveSkin() {
        super.resolveSkin()
        let spaceX:CGFloat = 100
        for i in 0..<20{
            let x:CGFloat = (i*spaceX)
            let str:String = x.string
            //Swift.print("str: " + "\(str)")
            let textArea:TextArea = TextArea(NaN,NaN,str,self)
            _ = addSubView(textArea)
            //Swift.print("CGPoint(x,0): " + "\(CGPoint(x,0))")
            textArea.setPosition(CGPoint(x,0))
            
        }
    }
}
