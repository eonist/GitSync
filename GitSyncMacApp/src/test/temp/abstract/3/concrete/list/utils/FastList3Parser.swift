import Foundation

class FastList3Parser {
    /**
     *
     */
    func selected(_ fastList:FastListable3){
        return pool.forEach{if($0.item === buttonEvent.origin){selectedIdx = $0.idx}}/*We extract the index by searching for the origin among the visibleItems, the view doesn't store the index it self, but the visibleItems store absolute indecies*/
    }
}
