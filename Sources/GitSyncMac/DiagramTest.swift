import Cocoa
@testable import Utils
@testable import Element

class DiagramTest {
    static func jsonTest(_ window:NSWindow){
        let content:String = "~/desktop/pet-grooming.json".content!
        let data = content.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let json:Any? = try? JSONSerialization.jsonObject(with: data, options: [])
        //JSONUtils.describe(json)
        
        let tree:CustomTree = CustomTree.tree(json)
        Swift.print("tree.title: " + "\(tree.title)")
        Swift.print("tree.children.count: " + "\(tree.children.count)")
        
        StyleManager.addStyle(Utils.diagramStyles)
        //createDiagram(window,tree)/*perfect triangle diagram*/
        pyramidify(window,tree)
    }
    /**
     * Creates a symmetrical pyramid diagram
     * NOTE: Padding is added through inner and outer shape trick. eases the spacing math
     */
    static func pyramidify(_ window:NSWindow,_ tree:CustomTree){
        //space out all children in a row so that their tot width is at the center of their parent
        tree.pt = CGPoint(900,200)
        centerAlignChildren(tree,tree.center)
        Pyramidifier.align(tree)
        let items = CustomTree.flattened(tree)/*Basically flattens 3d list into 2d list*/
        
        renderItems(window, items,tree)
    }
    /**
     * Spaces out all children in a row so that their tot width is at the center of their parent
     */
    static func centerAlignChildren(_ tree:CustomTree, _ parentPt:CGPoint, _ padding:CGPoint = CGPoint(0,100)){
        //space all levelSiblings out evenly
        let totW:CGFloat = CustomTree.totWidth(tree.children, padding)
        Swift.print("totW: " + "\(totW)")
        var x = parentPt.x - (totW/2)
        let y = parentPt.y + padding.y
        //
        tree.children.forEach{ child in
            child.pt = CGPoint(x,y)
            x = (x + child.width + padding.x)/*Increments x pos*/
            if !child.children.isEmpty { centerAlignChildren(child,child.center,padding) }/*recursive*/
        }
    }
    
    static func createDiagram(_ window:NSWindow, _ tree:CustomTree){
        CustomTree.distribute(tree, 0, CGRect(0,0,1400,300))
        let items = CustomTree.flattened(tree) //basically flattens 3d list into 2d list
        //Swift.print("items.count: " + "\(items.count)")
        renderItems(window, items,tree)
    }
    /**
     *
     */
    static func renderItems(_ window:NSWindow, _ items:[CustomTree], _ tree:CustomTree){
        let container = InteractiveView2()
        window.contentView = container
        
        
        
        let lineView = container.addSubView(InteractiveView2())
        let labelsView = container.addSubView(InteractiveView2())
        
        items.forEach{ item in
            //Swift.print("item.pt: " + "\(item.pt)")
            item.view.frame.origin = item.pt
            lineView.addSubview(item.lineGraphic.graphic)
            item.lineGraphic.graphic.frame.origin = item.pt
            labelsView.addSubview(item.view)
        }//places items into positions, should now be inverted tree
        
        
        func posLine(_ tree:CustomTree){//recursive
            tree.children.forEach{ child in
                let childP:CGPoint = child.pt
                let parentP:CGPoint = tree.pt
                let difference:CGPoint = parentP - childP
                let childCenter:CGPoint = child.lineGraphic.p1
                let p2:CGPoint = childCenter + difference
                child.lineGraphic.setPoints(childCenter, p2)
                posLine(child)
            }
        }
        posLine(tree)
    }
}

private class Utils{
    /**
     *
     */
    static var diagramStyles:String{
        /*Styles*/
        var css = ""
        css +=  "TextButton{fill:#30B07D;fill-alpha:1.0;corner-radius:10px;float:none;clear:none;}"
        css +=  "TextButton Text{"
        css +=  	"float:left;"
        css +=  	"clear:left;"
        css +=  	"width:100%;"
        css +=  	"margin-top:18px;"
        css +=  	"font:Helvetica Neue;"
        css +=  	"size:16px;"
        css +=  	"wordWrap:true;"
        css +=  	"align:center;"
        css +=  	"color:black;"
        css +=  	"selectable:false;"
        css +=  	"backgroundColor:orange;"
        css +=  	"background:false;"
        css +=  "}"
        return css
    }
}
