import Foundation
@testable import Utils

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
    class PathIdx{
        var idx:[Int]
        init(_ idx:[Int]){
            self.idx = idx
        }
    }
    /**
     * //Continue here: 🏀
     * TODO: you pass the depth along: [Int], and you return [PathIdx] which you concat at root
     * TODO: create the PathIdx Struct, and then use [[Int]] when you have figured it out
     * You increase the as you iterate,append when you dive
     * Eureka: Hash Array: You use a Sorted hashArray (Research required)
     */
    static func pathIndecies(_ tree:Tree,_ depth:[Int] = []) -> [PathIdx] {
        var depth:[Int] = depth + [0]
        var results:[PathIdx] = []
        for (i,child) in tree.children.enumerated(){
        //tree.children.forEach { child in
            depth.end = depth.end! + i
            if(child.children.count > 0) {/*Array*/
                return TreeUtils.pathIndecies(child,depth)
            }else{/*Item*/
                let pathIdx:PathIdx = PathIdx(depth)
                results.append(pathIdx)
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
