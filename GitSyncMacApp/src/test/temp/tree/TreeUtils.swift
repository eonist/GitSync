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
    typealias AssertMethod = (_ tree:Tree)->Bool
    static var defaultAssert:AssertMethod = {_ in return true}//returns true as default
    /**
     * New
     */
    static func pathIndecies(_ tree:Tree,_ idx:[Int] = [], _ assert:AssertMethod = defaultAssert) -> [[Int]] {
        let child:Tree = TreeParser.child(tree, idx)!
        return Utils.pathIndecies(child, [], assert)
    }
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
                _ = item.children += TreeUtils.tree(child).children
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
    static var isOpen:TreeUtils.AssertMethod = { tree in
        guard let props = tree.props, props["isOpen"] == "true" else {
            return false
        }
        return true
    }
    /**
     * New
     */
    static func hashList(_ tree:Tree) -> HashList{
        let pathIndecies:[[Int]] = TreeUtils.pathIndecies(tree,[],TreeUtils.isOpen)/*flattens 3d to 2d*/
        /*Swift.print("⚠️️")
         pathIndecies.forEach{
         Swift.print("$0: " + "\($0)")
         }*/
        //Swift.print("⚠️️")
        var arr:[String] = []
        var dict:[String:Int] = [:]
        pathIndecies.forEach{
            let key:String = $0.string
            arr.append(key)
            dict[key] = arr.count-1
        }
        return HashList(arr,dict)
    }
    /**
     * Used to debug Trees
     */
    static func describe(_ tree:Tree,_ key:String, _ level:Int = 0){
        if let props = tree.props, let value:String = props[key]{
            Swift.print(("\t" * level) +  value)
        }
        tree.children.forEach{describe($0, key, level + 1)}
    }
}
private class Utils{
    /**
     * Flattens a Tree-Structure to a path Indecies (3d -> 2d)
     * Eureka: Hash Array: You use a Sorted hashArray to solve the 3d->2d sync problem (Research required)
     */
    static func pathIndecies(_ tree:Tree,_ depth:[Int] = [], _ assert:TreeUtils.AssertMethod = TreeUtils.defaultAssert) -> [[Int]] {
        var depth:[Int] = depth + [0]
        var results:[[Int]] = []
        tree.children.forEach{
            results.append(depth)
            //Swift.print("$0.children.count > 0: " + "\($0.children.count > 0)")
            //Swift.print("assert($0): " + "\(assert($0))")
            if($0.children.count > 0 && assert($0)) {/*Array*/
                //Swift.print("dive deeper")
                results += Utils.pathIndecies($0,depth, assert)//dive deeper
            }
            depth.end = depth.end! + 1//increment cur level
        }
        return results
    }
}
