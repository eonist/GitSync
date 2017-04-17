import Foundation

class TreeModifier {
    /**
     * EXAMPLE XMLModifier.setAttributeAt(xml, [0,1], "title", "someTitle")
     * NOTE: I think this method works with depth indecies
     */
    static func setAttributeAt(_ tree:Tree,_ at:[Int], _ key:String,_ value:String)  {
        if let child = TreeParser.child(tree, at){
            if let props = child.props{
                props[key] = value
            }
        }
    }
    /*
    /**
     * EXAMPLE: setAttributeAt([0], ["title":"someTitle"]);
     * TODO: rename to changeAttribute? or editAttribute?
     */
    func setAttributeAt(_ index:[Int],_ attributes:[String:String]){// :TODO: 👉 do we still need the event dispatching, cant the calling method do this?👈
        _ = XMLModifier.setAttributeAt(xml, index, attributes)
        onEvent(NodeEvent(NodeEvent.setAttributeAt,index,self))
    }
    */
}
