import Foundation
@testable import Utils
@testable import Element

class Pyramidifier {
    /**
     * Aligns branch to the next branch (left to right)
     */
    static func align(_ tree:CustomTree){
        //branches = []//Store accumalitve branches
        
        //for i in tree.children
            //if not last branch
                //child
                //find maxX of branch
                //find minX of nextBranch
                //find dif of min and max. 
                //if diff is negative
                    //offset every item in branches with diff 
        
        //branch
        
        
    }
    
    /**
     * Returns max x position in a branch
     */
    func maxX(tree:CustomTree) -> CGFloat{
        let items = CustomTree.flattened(tree)/*Basically flattens 3d list into 2d list*/
        return items.reduce(items[0].right) {
            return $1.right > $0 ? $1.right : $0
        }
    }
    /**
     * Returns min x position in a branch
     */
    func minX(tree:CustomTree) -> CGFloat{
        let items = CustomTree.flattened(tree)/*Basically flattens 3d list into 2d list*/
        return items.reduce(items[0].left) {
            return $1.left < $0 ? $1.left : $0
        }
    }
}
