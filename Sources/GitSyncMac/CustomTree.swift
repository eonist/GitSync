import Cocoa
@testable import Utils
@testable import Element

class CustomTree{
    //var parent:CustomTree?
    var children:[CustomTree] = []
    var title:String {return attribs["title"] as? String ?? "title error"}
    var attribs:[String:Any] = [:]
    var pt:CGPoint = CGPoint()
    let w:CGFloat = 140
    let h:CGFloat = 50
    lazy var deepest:Int = {CustomTree.deepest(self)}()
    lazy var lineGraphic:LineGraphic = {
        let lineGraphic = LineGraphic(CGPoint(self.w/2,self.h/2),CGPoint(self.w/2,self.h/2),LineStyle(1,.blue))
        lineGraphic.draw()
        return lineGraphic
    }()
    lazy var view:NSView = {
        let textButton:TextButton = TextButton.init(self.w, self.h, self.title, nil)
        return textButton
    }()
}
extension CustomTree{
    var width:CGFloat {return view.frame.size.width}
    var height:CGFloat {return view.frame.size.height}
    var center:CGPoint {return CGPoint(width/2 + pt.x,height/2 + pt.y)}
    var left:CGFloat {return pt.x}
    var right:CGFloat {return pt.x + width}
}
extension CustomTree{
    /*Return siblings on same level*/
    static func siblings(_ tree:CustomTree,_ level:Int, _ curLevel:Int = 0) -> [CustomTree] {//4
        //Swift.print("tree title: \(tree.title) curLevel: \(curLevel)" )
        if curLevel == level {//correct level
            return [tree]
        }else{
            return tree.children.reduce([]) { result,child in
                return result + siblings(child,level,curLevel + 1)/*not correct level, keep diving*/
            }
        }
    }
    static func deepest(_ tree:CustomTree, _ depth:Int = 0) -> Int{/*num of levels on the deepest node from root*/
        return tree.children.reduce(depth) { deepestDepth, child in
            let curDeepest = deepest(child, depth + 1)
            return curDeepest > deepestDepth ? curDeepest : deepestDepth
        }
    }
    /**
     * So the idea is to evenly position from the center of parent position (inverted tree (aka hierarchy))
     * NOTE: ⚠️️ This method is recursive
     */
    static func distribute(_ tree:CustomTree, _ level:Int, _ prevBound:CGRect){/*recursive*/
        let padding:CGPoint = CGPoint(10,40)
        Swift.print("distribute tree title: \(tree.title) prevBound: \(prevBound)")
        /*align things here*/
        let siblings = CustomTree.siblings(tree,level)/*siblings are the items that are on the same level*/
        //let count = siblings.count
        Swift.print("siblings.count: " + "\(siblings.count)")
        let totW:CGFloat = CustomTree.totWidth(siblings, padding)
        Swift.print("totW: " + "\(totW)")
        Swift.print("prevBound.center.x: " + "\(prevBound.center.x)")
        var x = prevBound.center.x - (totW/2)//center of prev bound - halfTot
        let y = prevBound.bottom.y + padding.y
        let maxH = CustomTree.maxHeight(siblings)
        let curBound = CGRect(x,y,totW,maxH)
        //
        siblings.forEach{ child in
            child.pt = CGPoint(x,y)
            x = (x + child.width + padding.x)/*Increments x pos*/
        }
        //
        if level < tree.deepest {
            distribute(tree,level+1,curBound)/*Go to next level*/
        }
    }
    /**
     *
     */
    static func maxHeight(_ siblings:[CustomTree]) -> CGFloat{
        return siblings.map{$0.height}.reduce(0){$0 > $1 ? $0 : $1}
    }
    /**
     * figure out how much horizontal space all items take up
     */
    static func totWidth(_ siblings:[CustomTree], _ padding:CGPoint) -> CGFloat{
        return siblings.reduce(0){
            return $0 + $1.width + padding.x
            } - padding.x
    }
    /**
     * Recusivly flattens the the treeStructure into a column structure array of tree items (includes it self)
     * TODO: ⚠️️ Use reduce!
     */
    static func flattened(_ tree:CustomTree) -> [CustomTree] {
        var results:[CustomTree] = [tree]
        tree.children.forEach { child in
            if(child.children.count > 0) {/*Array*/
                results += CustomTree.flattened(child)
            }else{/*Item*/
                results.append(child)
            }
        }
        return results
    }
}
extension CustomTree {
    /**
     * Converts json to tree stucture
     */
    static func tree(_ json:Any?) -> CustomTree {
        //Swift.print("CustomTree.tree")
        let child = CustomTree()
        if let dict = JSONParser.dict(json) {
            //Swift.print("Dict.count: " + "\(dict.count)")
            dict.forEach { key,value in
                if let str = JSONParser.str(value){
                    child.attribs[key] = str
                }else if let int = JSONParser.int(value){
                    child.attribs[key] = int.string
                }else if let dictArr = JSONParser.dictArr(value) {//array with dict
                    dictArr.forEach{
                        if let dict = JSONParser.dict($0){
                            child.children.append(tree(dict))
                        }else{
                            fatalError("type not supported: \(type(of:json)) type \(JSONType.type(json))")
                        }
                    }
                }else if let arr = JSONParser.arr(value) {//array with any
                    var items:[String] = []
                    arr.forEach{
                        if let str = JSONParser.str($0){
                            items.append(str)
                        }else if let int = JSONParser.int($0){
                            items.append(int.string)
                        }else{
                            fatalError("type not supported: \(type(of:json)) type \(JSONType.type(json))")
                        }
                    }
                    child.attribs[key] = items//add items
                }else{
                    fatalError("type not supported: \(type(of:json)) type \(JSONType.type(json))")
                }
            }
        }else{
            fatalError("type not supported: \(type(of:json)) type \(JSONType.type(json))")
        }
        return child
    }
}
