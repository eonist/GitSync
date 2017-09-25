import Cocoa
@testable import Utils
@testable import Element

extension GraphScrollerHandler3{
    /**
     * utilities related
     */
    class Utils{
        /**
         * Returns the absolute index of an item based on x
         */
        static func index(x:CGFloat, width:CGFloat,totCount:Int) -> Int{
            let scalar:CGFloat = (-x)/width/* we flip the x to be positive*/
//            Swift.print("scalar: " + "\(scalar)")
            let index:Int = (scalar * totCount).int//goal is to get index
            return index
        }
        /**
         * Returns indecies from x,width,itemWidth
         * PARAM: width is the totalWidth of the list
         * NOTE; We can also use modulo to get index: modulo;reminder = x %% itemWidth;x - remainderro
         */
         static func indexRange(x:CGFloat, width:CGFloat, itemWidth:CGFloat, totCount:Int, visibleCount:Int ) -> (start:Int,end:Int){
            let idx:Int = index(x: x, width: width, totCount: totCount)
            if abs(x) > itemWidth {
                let end:Int = abs(x) < (width - itemWidth) ? idx+visibleCount+1 : idx+visibleCount
                return (start:idx-1,end:end)
            }else {
                return (start:idx,end:idx+visibleCount+2)
            }
        }
        /**
         * Returns points for index range
         */
        private static func vValues(indexRange:(start:Int,end:Int),itemAt:(Int)->Int?) -> [Int]{
            return (indexRange.start..<indexRange.end).indices.map{ (i:Int) in
                return itemAt(i) ?? 0//{fatalError("no point at:\(i) this index")}()
            }
        }
        /**
         * Returns points
         */
        static func vValues(x:CGFloat, width:CGFloat, itemWidth:CGFloat, totCount:Int, visibleCount:Int, itemAt:(Int)->Int?) -> [Int]{
            let idxRange = indexRange(x: x, width: width, itemWidth: itemWidth, totCount: totCount, visibleCount: visibleCount)
            let vVals = vValues(indexRange: idxRange, itemAt: itemAt)
            return vVals
        }
        
        /**
         * a method that returns xValues for (x,w,itemWidth,visCount)
         */
        static func xValues(x:CGFloat, width:CGFloat,itemWidth:CGFloat,totCount:Int,visCount:Int) -> [CGFloat]{
            let idx:Int = index(x: x, width: width, totCount: totCount)
//            Swift.print("idx: " + "\(idx)")
            return (idx..<(idx+visCount)).indices.map{
                return itemWidth * $0
            }
        }
        /**
         *
         */
//        static func points(){
//            
//        }
        
        //old
        
        /**
         * New
         * PARAM: width: the maskSize.width
         */
        
        //        static func calcMinY(x:CGFloat, width:CGFloat, points:[CGPoint]) -> CGFloat{
        //            let x1:CGFloat = -1 * x/*Here we flip the x to be positive*/
        //            let x2:CGFloat = (-1 * x) + width
        //            /**/
        //            let minX:CGFloat = x1/*The begining of the current visible graph*/
        //            let maxX:CGFloat = x2/*The end of the visible range*/
        //            let minY:CGFloat = Utils.minY(minX:minX,maxX:maxX,points:points)/*Returns the smallest Y value in the visible range*/
        //            return minY
        //        }
    
        static func calcPointsWithin(x:CGFloat, width:CGFloat, points:[CGPoint],padding:CGFloat = 200) -> [CGPoint]{
            let minMax = Utils.minMax(x: x, width: width,padding:padding)
            return pointsWithin(minX: minMax.min, maxX: minMax.max, points: points)
        }
        /**
         * New
         * PARAM: padding: so that the points don't go out of view, when scrolling
         */
        static func minMax(x:CGFloat, width:CGFloat, padding:CGFloat = 200) -> (min:CGFloat,max:CGFloat){
            let x1:CGFloat = -1 * x/*Here we flip the x to be positive*/
            let x2:CGFloat = (-1 * x) + width
            //for some strange reason you need 200px padding. But you should only need 100px
            //            let padding:CGFloat = padding//
            let minX:CGFloat = x1 - padding/*The begining of the current visible graph*/
            let maxX:CGFloat = x2 + padding/*The end of the visible range*/
            return (minX,maxX)
        }
        /**
         * Returns minY for the visible section of the graph
         * NOTE: The visible graph is the portion of the graph that is visible at any given progression.
         * PARAM: minX: The begining of the current visible graph
         * PARAM: maxX: The end of the visible range
         */
        static func minY(x:CGFloat,width:CGFloat,points:[CGPoint],padding:CGFloat = 200) -> CGFloat {
            //          let yValuesWithinMinXAndMaxX:[CGFloat] = points.filter{$0.x >= minX && $0.x <= maxX}.map{$0.y}/*We gather the points within the current minX and maxX*/
            return calcPointsWithin(x: x, width: width, points: points, padding:padding).map{$0.y}.min()!
        }
        /**
         * New
         */
        static func pointsWithin(minX:CGFloat,maxX:CGFloat,points:[CGPoint]) -> [CGPoint]{
            return points.filter{$0.x >= minX && $0.x <= maxX}.map{$0}/*We gather the points within the current minX and maxX*/
        }
        /**
         * New
         */
        static func calcRatio(/* x:CGFloat, */minY:CGFloat, height:CGFloat) -> CGFloat{
            //let dist:CGFloat = 400.cgFloat.distance(to: minY)
            if minY == height {return 1}//dividing with zero only yields infinity. This avoids that
            let diff:CGFloat = height + (-minY)/*Since graphs start from the bottom we need to flip the y coordinates*/
            let ratio:CGFloat = height / diff/*Now that we have the flipped y coordinate we can get the ratio to scale all other points with */
            return ratio
        }
        /**
         * New
         */
        static func calcScaledPoints(points:[CGPoint], ratio:CGFloat, height:CGFloat) -> [CGPoint]{
            let scaledPoints = points.map{CGPointModifier.scale($0/*<--point to scale*/, CGPoint($0.x,height)/*<--pivot*/, CGPoint(1,ratio)/*<--Scalar ratio*/)}
            return scaledPoints
        }
    }
}
