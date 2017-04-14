import Foundation
@testable import Utils

class TreeUtils{
    static func recursiveFlattened(_ tree:Tree) -> [Tree] {
        var results:[Tree] = []
        for child in tree.children {
            if(child.children.count > 0) {/*Array*/
                results += TreeUtils.recursiveFlattened(child)
            }else{/*Item*/
                results.append(child)
            }
        }
        return results
    }
    /**
     * Convert xml to Tree-struture
     */
    static func tree(_ xml:XML) -> Tree{
        var tree:Tree = Tree()
        let count = xml.children!.count//or use rootElement.childCount TODO: test this
        for i in 0..<count{
            let child:XML = XMLParser.childAt(xml.children!, i)!
            var item:Tree = Tree()
            let attribs = child.attribs
            if(!attribs.isEmpty){
                item.props = attribs
            }
            if let content = child.stringValue, content.count > 0 {
                item.content = content
            }else if(child.hasComplexContent) {
                _ = item.children += TreeUtils.tree(child)
            }
            tree.add(item)
        }
        return tree
    }
    /**
     *
     */
    static func xml(_ tree:Tree) -> XML{
        /**
         * Array types
         */
        //Swift.print("handleArray: " + "name \(name)" + " $0.value: \(value)" )
        let xml = XML()
        xml.name = tree.name
        if(tree.content){xml.value = }
        //xml["type"] = "Array"
        //Swift.print("handleArray.properties.count: " + "\(properties.count)")
        tree.children.forEach{ child in
            
            /*if($0.value is Reflectable){/*The type implements custom reflection*/
                //Swift.print("$0.value: " + "\($0.value)")
                xml += handleReflectable($0.value as! Reflectable,"item"/*$0.label*/)
            }else if (stringConvertiable($0.value)){/*<--asserts if the value can be converted to a string*/
                //Swift.print("array value: stringConvertiable")
                xml += handleBasicValue($0.value,"item")
            }else if($0.value is AnyArray){/*array*/
                xml += handleArray($0.value,$0.label)//<--should this also be: "item" as label in an array is always [0],[1] etc
            }else if ($0.value is AnyDictionary){/*dictionary*/
                //Swift.print("value is AnyDict")
                xml += handleDictionary($0.value,$0.label)//<--should this also be: "item" as label
            }else if(CFGetTypeID($0.value as AnyObject) == CGColor.typeID){
                xml += handleReflectable($0.value as! CGColor,"item")
            }else{/*all other cases*/
                //Swift.print("array value: else")
                xml += handleValue($0.value)
                //fatalError("unsuported type: " + "\($0.value.dynamicType)")
            }*/
        }
        
        

        
        return xml
    }
}
