import Foundation
@testable import Utils

/*class PathIdx{
 var idx:[Int]
 init(_ idx:[Int]){
 self.idx = idx
 }
 }*/
class TreeUtils{
    /**
     * Recusivly flattens the the treeStructure into a column structure array of tree items
     */
    static func flattened(_ tree:Tree) -> [Tree] {
        var results:[Tree] = []
        tree.children.forEach { child in
            if(child.children.count > 0) {/*Array*/
                results += TreeUtils.flattened(child)
            }else{/*Item*/
                results.append(child)
            }
        }
        return results
    }
    
    /**
     * Flattens a Tree-Structure to a path Indecies (3d -> 2d)
     * Eureka: Hash Array: You use a Sorted hashArray (Research required)
     */
    static func pathIndecies(_ tree:Tree,_ depth:[Int] = []) -> [[Int]] {
        var depth:[Int] = depth + [0]
        var results:[[Int]] = []
        for (i,child) in tree.children.enumerated(){
            depth.end = depth.end! + i
            if(child.children.count > 0) {/*Array*/
                results += TreeUtils.pathIndecies(child,depth)
            }else{/*Item*/
                results.append(depth)
            }
        }
        return results
    }
    /**
     * Convert xml to Tree-struture
     */
    static func tree(_ xml:XML) -> Tree{
        var tree:Tree = Tree()
        tree.name = xml.name
        let count = xml.children!.count//or use rootElement.childCount TODO: test this
        for i in 0..<count{
            let child:XML = XMLParser.childAt(xml.children!, i)!
            var item:Tree = Tree()
            item.name = child.name
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
            let childXML:XML = TreeUtils.xml(child)
            xml += childXML
        }
 
        return xml
    }
}
