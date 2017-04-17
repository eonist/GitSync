import Foundation
@testable import Utils

class TreeModifier {
    /**
     * EXAMPLE XMLModifier.setAttributeAt(xml, [0,1], "title", "someTitle")
     * NOTE: I think this method works with depth indecies
     */
    static func setProp(_ tree:inout Tree,_ at:[Int], _ prop:(key:String,val:String))  ->Tree{
        //may work
        var child = TreeParser.child(tree, at)
        child?.props?[prop.key] = prop.val
        return tree
    }
    /**
     * EXAMPLE: setAttributeAt([0], ["title":"someTitle"]);
     * TODO: rename to changeAttribute? or editAttribute?
     */
    static func setProp(_ tree:inout Tree,_ at:[Int],_ props:[String:String]){
        for (k, v) in props{
            _ = TreeModifier.setProp(&tree, at, (k, v))
        }
    }
    typealias ApplyMethod = (_ tree:Tree)->Void
    static func apply(_ tree:Tree?,_ index:[Int], _ apply:ApplyMethod){
        if(index.count == 0 && tree != nil) {
            apply(tree!)
        }else if(index.count == 1 && tree != nil && tree![index.first!] != nil) {//XMLParser.childAt(xml!.children!, index[0])
            apply(tree![index[0]]!)
        }// :TODO: if index.length is 1 you can just ref index
        else if(index.count > 1 && tree!.children.count > 0) {
            TreeModifier.apply(tree![index.first!], index.slice2(1,index.count),apply)//keep digging
        }
    }
}
