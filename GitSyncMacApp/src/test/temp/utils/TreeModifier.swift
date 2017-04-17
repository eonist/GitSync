import Foundation
@testable import Utils

class TreeModifier {
    /**
     * EXAMPLE XMLModifier.setAttributeAt(xml, [0,1], "title", "someTitle")
     * NOTE: I think this method works with depth indecies
     */
    static func setProp(_ tree:inout Tree,_ at:[Int], _ prop:(key:String,val:String)) {
        //may work
        let apply:ApplyMethod = {tree in
            tree.props?[prop.key] = prop.val
        }
        TreeModifier.apply(&tree, at, apply)
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
    typealias ApplyMethod = (_ tree:inout Tree)->Void
    /**
     * New
     * TODO: Clean up with if let and guard
     */
    static func apply(_ tree:inout Tree, _ index:[Int], _ apply:ApplyMethod){
        if(index.count == 0) {
            apply(&tree)
        }else if(index.count == 1 && tree[index.first!] != nil) {
            apply(&tree[index[0]]!)
        }else if(index.count > 1 && tree.children.count > 0) {
            TreeModifier.apply(&tree[index.first!]!, index.slice2(1,index.count),apply)//keep digging
        }
    }
}
