import Foundation

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
}
