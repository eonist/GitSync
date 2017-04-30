import Foundation
@testable import Utils
@testable import Element

class TreeConverter {
    /**
     * Convert xml to Tree-struture
     */
    static func tree(_ xml:XML) -> Tree{
        var tree:Tree = Tree()
        tree.name = xml.name
        //let count = xml.children!.count//or use rootElement.childCount TODO: test this
        xml.children?.forEach{
            let child:XML = $0 as! XML
            var item:Tree = Tree()
            item.name = child.name
            let attribs:[String:String] = child.attribs
            //Swift.print("attribs.isEmpty: " + "\(attribs.isEmpty)")
            if(!attribs.isEmpty){
                item.props = attribs
            }
            if let content = child.stringValue, content.count > 0 {
                item.content = content
            }else if(child.hasComplexContent) {
                _ = item.children += TreeConverter.tree(child).children
            }
            tree.add(item)
        }
        return tree
    }
    /**
     * Converts Tree to XML
     */
    static func xml(_ tree:Tree) -> XML{
        /**
         * Array types
         */
        //Swift.print("handleArray: " + "name \(name)" + " $0.value: \(value)" )
        func toXML(_ tree:Tree)->XML{
            let xml = XML()
            xml.name = tree.name
            if(tree.content != nil){xml.stringValue = tree.content}
            if(tree.props != nil){xml.setAttributesWith(tree.props!)}
            return xml
        }
        
        let xml:XML = toXML(tree)
        tree.children.forEach{ child in/*This can be a single .map method*/
            let childXML:XML = TreeConverter.xml(child)
            xml += childXML
        }
        return xml
    }
}
