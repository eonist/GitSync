import Foundation

class TreeModifier {
    /**
     * EXAMPLE XMLModifier.setAttributeAt(xml, [0,1], "title", "someTitle")
     * NOTE: I think this method works with depth indecies
     */
    static func setAttributeAt(_ tree:Tree,_ at:[Int], _ key:String,_ value:String)  {
        if let child = TreeParser.child(tree, at){
            child[key] = value
        }
    }
}
