import Foundation

class TreeModifier {
    /**
     * EXAMPLE XMLModifier.setAttributeAt(xml, [0,1], "title", "someTitle")
     * NOTE: I think this method works with depth indecies
     */
    static func setProp(_ tree:inout Tree,_ at:[Int], _ key:String,_ value:String)  {
        //may work
        var child = TreeParser.child(tree, at)
        child?.props?[key] = value
    }
    /**
     * EXAMPLE: setAttributeAt([0], ["title":"someTitle"]);
     * TODO: rename to changeAttribute? or editAttribute?
     */
    func setProps(_ tree:inout Tree,_ at:[Int],_ props:[String:String]){
        for (k, v) in props{
            TreeModifier.setProp(&tree, at, k, v)
        }
    }
}
