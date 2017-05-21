import Foundation
@testable import Utils
@testable import Element

class Pyramidifier {
    /**
     * Aligns branch to the next branch (left to right)
     */
    static func align(_ tree:CustomTree){
        //branches = []//Store accumalitve branches
        
        for i in tree.children.indices {
            
            if (i < (tree.children.count - 1)) {//if not last branch
                let child:CustomTree = tree.children[i]
                let maxX = maxX(child)
                
            }
        }
        //for i in tree.children
            //if not last branch
                //child
                //find maxX of branch
                //find minX of nextBranch
                //find diff of min and max.
                //if diff is negative
                    //offset every item in branches with diff 
        
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
