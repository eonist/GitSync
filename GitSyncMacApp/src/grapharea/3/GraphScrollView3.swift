import Cocoa
@testable import Utils
@testable import Element
/**
 * Alt name: GraphScroller3
 * Consider drawing GraphDots the same way you draw Graph line. This way it will be easier to implement the pinch in and out gestures later 👌
 */
class GraphScrollView3:ElasticScrollerFastList5 {
    override lazy var moverGroup:MoverGroup = self.createCustomMoverGroup
    //
    private var graphScrollerHandler:GraphScrollerHandler3 {return handler as! GraphScrollerHandler3}//move this to extension somewhere
    override lazy var handler:ProgressHandler = GraphScrollerHandler3(progressable:self)
    override var contentSize:CGSize {return CGSize(100*dp.count,super.getHeight())}
    //
    let points:[CGPoint]//you could bundle points in db, but then use DP2 it has generics
    //
    var prevX:CGFloat = -100
//    var prevPoints:[CGPoint]?/*Interim var*/
//    var newPoints:[CGPoint]?
    var animator:NumberSpringer?
    var prevMinY:CGFloat?//prevMinY to avoid calling start anim
    var graphArea:GraphAreaX
   //
    init(graphArea:GraphAreaX, points:[CGPoint], config: List5.Config, size: CGSize, id: String? = nil) {
        self.graphArea = graphArea
        self.points = points
        super.init(config: config, size: size, id: id)
    }
    override func createItem(_ index:Int) -> Element {
        Swift.print("createItem index: \(index)")
        let item = GraphScrollerItem.init(point: points[index], /*index: index, */size: itemSize)
        contentContainer.addSubview(item)
        return item
    }
    override func reUse(_ listItem:FastListItem) {
        let item:GraphScrollerItem = listItem.item as! GraphScrollerItem//use guard here
        //Update debug color rect:
        let randCol:NSColor = NSColorParser.randomColor()
        item.rect!.graphic.fillStyle = FillStyle(randCol)
        item.rect!.draw()
        //Update GraphDot:
        let pt = points[listItem.idx]
        listItem.item.layer?.position[dir] = listItem.idx * itemSize[dir]/*position the item*/
        item.graphDot!.layer?.position = CGPoint(0,pt.y)/*Moves the points*/
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented") }
}

extension GraphScrollView3{
    var createCustomMoverGroup:MoverGroup {//TODO: 🏀 Rename to createMoverGroup
//        let setProgress = { (_ value:CGFloat,_ dir:Dir) -> Void in
////            guard dir == .hor else {return}//forces hor as major direction only
////            self.contentContainer.layer?.position[dir] = value
//            GraphScrollerHandler3
//        }
        //setProgressValue
        var group = MoverGroup(graphScrollerHandler.setProgressValue,self.maskSize,self.contentSize)
        group.event = (self as EventSendable).onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
        return group
    }
}


