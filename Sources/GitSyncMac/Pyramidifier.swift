import Foundation
@testable import Utils
@testable import Element

class Pyramidifier {
    /**
     * Aligns branch to the next branch (left to right)
     */
    static func align(_ tree:CustomTree){
        var accumulated:[CustomTree] = []//Store accumalitve branches
        
        for i in tree.children.indices {
            if (i < (tree.children.count - 1)) {//if not last branch
                let child:CustomTree = tree.children[i]
                let next:CustomTree = tree.children[i+1]
                let maxX = Pyramidifier.maxX(child)//find maxX of branch
                let minX = Pyramidifier.minX(next)//find minX of nextBranch
                let items = CustomTree.flattened(child)
                accumulated += items//accumulate all items
                if maxX > minX {//if diff is negative
                    let diff = minX - maxX//find diff of min and max.
                    accumulated.forEach{$0.pt.x += diff}//offset every item in branches with diff
                }
            }
        }
        let isOdd:Bool = (tree.children.count.cgFloat %% 2.0) != 0.0
        if isOdd {//1,3,5,7 etc
            Swift.print("odd")
            let mid:Int = ((tree.children.count+1)/2)-1
            Swift.print("mid: " + "\(mid)")
            let midChild = tree.children[mid]
            tree.pt.x = midChild.pt.x + (midChild.width/2) - (tree.width/2)
        }else{//even 0,2,4, etc
            Swift.print("even")
            if let left = tree.children.first?.left, let right = tree.children.last?.right  {
                tree.pt.x = tree.children[0].pt.x + ((right - left)/2) - (tree.width/2) //center root to children bounds.center
            }
        }
        
        
    }
    /**
     * Returns max x position in a branch
     */
    private static func maxX(_ tree:CustomTree) -> CGFloat{
        let items = CustomTree.flattened(tree)/*Basically flattens 3d list into 2d list*/
        return items.reduce(items[0].right) {
            return $1.right > $0 ? $1.right : $0
        }
    }
    /**
     * Returns min x position in a branch
     */
    private static func minX(_ tree:CustomTree) -> CGFloat{
        let items = CustomTree.flattened(tree)/*Basically flattens 3d list into 2d list*/
        return items.reduce(items[0].left) {
            return $1.left < $0 ? $1.left : $0
        }
    }
}
