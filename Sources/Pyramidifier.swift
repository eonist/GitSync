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
       
    }
    /**
     * Returns max x position in a branch
     */
    static func maxX(_ tree:CustomTree) -> CGFloat{
        let items = CustomTree.flattened(tree)/*Basically flattens 3d list into 2d list*/
        return items.reduce(items[0].right) {
            return $1.right > $0 ? $1.right : $0
        }
    }
    /**
     * Returns min x position in a branch
     */
    static func minX(_ tree:CustomTree) -> CGFloat{
        let items = CustomTree.flattened(tree)/*Basically flattens 3d list into 2d list*/
        return items.reduce(items[0].left) {
            return $1.left < $0 ? $1.left : $0
        }
    }
}
