import Cocoa

class FastList3Parser {
    /**
     * We extract the index by searching for the origin among the visibleItems, the view doesn't store the index it self, but the visibleItems store absolute indecies
     */
    static func selected(_ fastList:FastListable3, _ item:NSView) -> Int?{
        for (i,obj) in fastList.pool.enumerated(){
            if(obj.item === item){
                let i:Int = obj.idx
                return i
            }
        }
        return nil
    }
}
