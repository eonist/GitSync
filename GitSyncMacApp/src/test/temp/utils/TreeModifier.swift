import Foundation
@testable import Utils

class TreeModifier {
    typealias ApplyMethod = (_ tree:inout Tree)->Void
    /**
     * EXAMPLE XMLModifier.setAttributeAt(xml, [0,1], "title", "someTitle")
     * NOTE: I think this method works with depth indecies
     */
    static func setProp(_ tree:inout Tree,_ idx3d:[Int], _ prop:(key:String,val:String)) {
        //may work
        let apply:ApplyMethod = {tree in//maybe move into global class scope
            tree.props?[prop.key] = prop.val
        }
        TreeModifier.apply(&tree, idx3d, apply)
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
    /**
     * Applies a method at PARAM: idx3d
     * TODO: Clean up with multi if let and guard
     * NOTE: Recursivly traverses the hierarchy until it finds the idx3d and then applies the apply method to the item at idx3d
     */
    static func apply(_ tree:inout Tree, _ idx3d:[Int], _ apply:ApplyMethod){
        if(idx3d.count == 0) {
            apply(&tree)
        }else if(idx3d.count == 1 && tree[idx3d.first!] != nil) {
            apply(&tree[idx3d[0]]!)
        }else if(idx3d.count > 1 && tree.children.count > 0) {
            TreeModifier.apply(&tree[idx3d.first!]!, idx3d.slice2(1,idx3d.count),apply)//keep digging
        }
    }
    /**
     *
     */
    static func append(_ tree: inout Tree,_ idx3d:[Int],_ child:Tree){
        tree[idx3d]?.children.append(child)
    }
    /**
     * IMPORTANT: idx3d must have at least one value
     */
    static func remove(_ tree: inout Tree,_ idx3d:[Int],_ at:Int){
        if idx3d.count == 1 {
            tree.children.removeAt(idx3d[0])
        }else if idx3d.count > 1{
            let parentIdx3d:[Int] = Array(idx3d[0...(idx3d.count-1)])
            tree[parentIdx3d]?.children.remove(at: idx3d.last!)
        }else{
            fatalError("Index not supported: \(idx3d)")
        }
    }
}
