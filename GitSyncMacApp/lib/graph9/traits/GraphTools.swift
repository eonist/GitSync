import Cocoa
@testable import Utils
@testable import Element

class GraphTools {
    static func randomGraphPoints(_ padding:CGFloat,_ itemSize:CGSize, _ size:CGSize) -> [CGPoint]{
        typealias P = CGPoint
        var points:[P] = []
        //let padding:CGFloat = 50
        for i in 0..<7{
            let x:CGFloat = padding+(itemSize.width*i)
            let y:CGFloat = (0..<(size.height.int-32)).random.cgFloat
            let p = P(x,y)
            points.append(p)
        }
        return points
    }
}
