import Cocoa
@testable import Utils
@testable import Element

class GraphTools {
    static func randomGraphPoints(_ leftPadding:CGFloat,_ xSpacing:CGFloat, _ height:CGFloat) -> [CGPoint]{
        typealias P = CGPoint
        var points:[P] = []
        //let padding:CGFloat = 50
        for i in 0..<7{
            let x:CGFloat = leftPadding+(xSpacing*i)
            let y:CGFloat = (0..<(height.int-32)).random.cgFloat
            let p = P(x,y)
            points.append(p)
        }
        return points
    }
}
