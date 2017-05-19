import Cocoa
@testable import Utils
@testable import Element

class CustomTree{
    var shape:NSView {return NSView()}
    var parent:CustomTree?
    var children:[CustomTree] = []
    var title:String
    var pt:CGPoint = CGPoint()
    init(_ title:String){
        self.title = title
    }
}
extension CustomTree{
    var width:CGFloat {return shape.frame.size.width}
    var height:CGFloat {return shape.frame.size.height}
}
extension CustomTree{
    /*Return siblings on same level*/
    static func siblings(_ tree:CustomTree,_ level:Int, _ curLevel:Int = 0) -> [CustomTree] {//4
        //Swift.print("tree title: \(tree.title) curLevel: \(curLevel)" )
        if curLevel == level {//correct level
            return [tree]
        }else{
            return tree.children.reduce([]) { result,child in
                return result + siblings(child,level,curLevel + 1)/*not correct level, keep diving*/
            }
        }
    }
    static func deepest(_ tree:CustomTree, _ depth:Int = 0) -> Int{/*num of levels on the deepest node from root*/
        return tree.children.reduce(depth) { deepestDepth, child in
            let curDeepest = deepest(child, depth + 1)
            return curDeepest > deepestDepth ? curDeepest : deepestDepth
        }
    }
    //inverted tree (aka hierarchy)
    /**
     * So the idea is to evenly position from the center of parent position
     */
    static func distribute(_ tree:CustomTree, _ level:Int, _ prevBound:CGRect){/*recursive*/
        /*align things here*/
        let siblings = CustomTree.siblings(tree,level)/*siblings are the items that are on the same level*/
        //let count = siblings.count
        //figure out how much horizontal space all items take up
        let totW:CGFloat = siblings.reduce(0){
            return $0 + $1.width
        }
        var x = prevBound.center.x - (totW/2)//center of prev bound - halfTot
        let y = prevBound.bottom.y
        _ = siblings.map{
            $0.pt = CGPoint(x,y)
            x += x + $0.width
        }
        let maxH = siblings.map{$0.height}.reduce(0){$0 > $1 ? $0 : $1}
        let curBound = CGRect(x,y,totW,maxH)
        if level <= CustomTree.deepest(tree) {
            distribute(tree,level+1,curBound)
        }
    }
}
