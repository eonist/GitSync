import Cocoa
@testable import Utils
@testable import Element

class GraphTools {//rename to GraphUtils
    static func randomGraphPoints(_ leftPadding:CGFloat,_ xSpacing:CGFloat, _ height:CGFloat) -> [CGPoint]{
        typealias P = CGPoint
        var points:[P] = []
        let topMargin:CGFloat = 50
        //let padding:CGFloat = 50
        for i in 0..<7{
            let x:CGFloat = leftPadding+(xSpacing*i)
            let y:CGFloat = (0..<(height.int-32)).random.cgFloat
            let p = P(x,y+topMargin)
            points.append(p)
        }
        return points
    }
}
extension Graph9{
    func alignTimeBar(){
        let objSize = CGSize(w,24)
        //Swift.print("objSize: " + "\(objSize)")
        let canvasSize = CGSize(w,h)
        //Swift.print("canvasSize: " + "\(canvasSize)")
        let p = Align.alignmentPoint(objSize, canvasSize, Alignment.bottomLeft, Alignment.bottomLeft, CGPoint())
        //Swift.print("p: " + "\(p)")
        //align timeBar to bottom with Align
        timeBar!.point = p
    }
}
