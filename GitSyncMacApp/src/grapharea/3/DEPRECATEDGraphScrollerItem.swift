import Cocoa
@testable import Utils
@testable import Element

class GraphScrollerItem:Container {
//    let index:Int
    let point:CGPoint
    var graphDot:Element?
    var rect:RectGraphic?
    init(point:CGPoint,/* index:Int, */size:CGSize, id: String? = nil) {
        self.point = point
//        self.index = index
        super.init(size: size, id: id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        let randCol:NSColor = NSColorParser.randomColor()
        
        //
        rect = RectGraphic(0,0,skinSize.w,skinSize.h,FillStyle(randCol))
        rect!.draw()
        self.addSubview(rect!.graphic)
//      //Point
        let pt = point
        Swift.print("pt: " + "\(pt)")
        //GraphDot
        graphDot = Element.init(size: CGSize(0,0), id:"graphPoint")
//
        self.addSubview(graphDot!)
        graphDot!.layer?.position = CGPoint(0,pt.y)/*Moves the points*/
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

//continue here: 🏀
    //add the graphDots back! 👈



