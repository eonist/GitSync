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
     *
     */
    static func tree(_ xml:XML) -> Tree{
        var tree:Tree = Tree()
        let count = xml.children!.count//or use rootElement.childCount TODO: test this
        for i in 0..<count{
            let child:XML = XMLParser.childAt(xml.children!, i)!
            //print("Import - child.toXMLString(): " + child.toXMLString());
            var item:[Any] = []
            let attribs = child.attribs
            if(!attribs.isEmpty){
                item.append(attribs)
            }
            if(child.stringValue != nil && child.stringValue!.count > 0) {
                item.append(child.stringValue!)
            }else if(child.hasComplexContent) {
                item.append(arr(child))
            }
            items.append(item)
        }
        return items
    }
}
