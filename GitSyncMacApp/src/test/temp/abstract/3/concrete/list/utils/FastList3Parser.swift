import Cocoa

class FastList3Parser {
    /**
     * We extract the index by searching for the origin among the visibleItems, the view doesn't store the index it self, but the visibleItems store absolute indecies
     */
    static func selected(_ fastList:FastListable3, _ item:NSView) -> Int?{
        //use filter on the bellow
        return fastList.pool.filter(){return $0.item === item}
        /*for obj in fastList.pool{
         if(obj.item === item){
         return obj.idx
         }
         }
         return nil*/
    }
}
