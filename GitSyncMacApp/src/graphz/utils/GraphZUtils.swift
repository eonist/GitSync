import Foundation
@testable import Utils
@testable import Element

class GraphZUtils {
    /**
     * New
     * Returns graph points (Basically the coordinates of where to place the visual graph points)
     */
    static func points(rect:CGRect, spacing:CGSize, xProgress:CGFloat, totContentWidth:CGFloat, totCount:Int, visibleCount:Int, itemAt:(Int) -> Int? ,maxValue:Int?) -> [CGPoint]{
        let idxRange:(start:Int,end:Int) = GraphScrollerHandler3.Utils.indexRange(x: xProgress, width: totContentWidth, itemWidth: spacing.w, totCount: totCount, visibleCount: visibleCount)
        let vValues:[Int] = Utils.vValues(indexRange: idxRange, itemAt: itemAt)
//        Swift.print("vValues.count: " + "\(vValues.count)")
        let maxValue:Int = maxValue != nil ? maxValue! : vValues.max() ?? {fatalError("err: \(vValues.count)")}()/*Finds the largest number in among vValues*/
        //
        let x:CGFloat = rect.x//spacing.width
        let y:CGFloat = rect.height - (rect.y)//the y point to start from, basically bottom
        let h:CGFloat = rect.height - (rect.y)//the height to work within
        //TODO: ⚠️️ use enumerated and get the vVal as well on the bellow line
//        Swift.print("(idxRange.start..<idxRange.end).indices.count: " + "\((idxRange.start..<idxRange.end).indices.count)")
        return vValues.indices.map{ (i:Int) in//i is relative index
            let p:CGPoint = {
                let value:CGFloat = vValues[i].cgFloat
                let ratio:CGFloat = value/maxValue.cgFloat/*a value between 0-1*/
                //ratio = ratio.isNaN ? 0 : ratio//cases can be
                //Swift.print("ratio: " + "\(ratio)")
                let dist:CGFloat = h*ratio
                let e:Int = idxRange.start + i//absolute index
                let x:CGFloat = x + (e * spacing.width)
                let y:CGFloat = y - dist
                let _y:CGFloat = y.isNaN ? rect.height - rect.y : y//⚠️️ quick fix, for when vValue is 0
                return CGPoint(x,_y)
            }()
            return p
        }
    }
    /**
     * New
     */
    static func minY(pts:[CGPoint]) -> CGFloat{
        let subSet:[CGPoint] = pts//pts.slice2(0, pts.count-1)
//        Swift.print("subSet.count: " + "\(subSet.count)")
        let minY:CGFloat = subSet.map{$0.y}.min() ?? {fatalError("err")}()
        return minY
    }
}
private class Utils{
    /**
     * Returns points for index range
     */
    static func vValues(indexRange:(start:Int,end:Int), itemAt:(Int)->Int?) -> [Int]{
        return (indexRange.start..<indexRange.end).indices.map{ (i:Int) in
            return itemAt(i) ?? 0//{fatalError("no point at:\(i) this index")}()
        }
    }
}
