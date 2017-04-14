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
            if(child.stringValue != nil && child.stringValue!.count > 0) {
                item.content = child.stringValue!
            }else if(child.hasComplexContent) {
                _ = item.children += TreeUtils.tree(child)
            }
            tree.add(item)
        }
        return tree
    }
}
