import Cocoa
@testable import Utils
@testable import Element

class GraphScrollView3:ElasticScrollList5 {
    override lazy var moverGroup:MoverGroup = self.createCustomMoverGroup
    //
    private var graphScrollerHandler:GraphScrollerHandler3 {return handler as! GraphScrollerHandler3}//move this to extension somewhere
    override lazy var handler:ProgressHandler = GraphScrollerHandler3(progressable:self)
    override var contentSize:CGSize {return CGSize(100*dp.count,super.getHeight())}
    //
    let points:[CGPoint]//you could bundle points in db, but then use DP2 it has generics
    //
    var prevX:CGFloat {get{return (progressable as! GraphScrollView3).prevX} set{(progressable as! GraphScrollView3).prevX = newValue}}
    //
    init(points:[CGPoint], config: List5.Config, size: CGSize, id: String? = nil) {
        self.points = points
        super.init(config: config, size: size, id: id)
    }
    //
    override func createItem(_ dict: [String : String], _ i: Int) -> NSView {
        let randCol:NSColor = NSColorParser.randomColor()
        let x = i * itemSize.w
        Swift.print("x: " + "\(x)")
        //
        let container = Container.init(size: itemSize)
        container.resolveSkin()
        container.setPosition(CGPoint(x,0))
        //
        let rect = RectGraphic(0,0,itemSize.w,itemSize.h,FillStyle(randCol))
        
        rect.draw()
        container.addSubview(rect.graphic)
        //Point
        let pt = points[i]
        Swift.print("pt: " + "\(pt)")
        //GraphDot
        let graphDot:Element = Element.init(size: CGSize(0,0), id:"graphPoint")
        
        container.addSubview(graphDot)
        graphDot.layer?.position = CGPoint(0,pt.y)/*Moves the points*/
        //
        return container
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented") }
}
class GraphScrollerHandler3:ElasticScrollerHandler5/*,GraphScrollerDecorator*/{
    //onScroll -> tick -> update y value of graph points
    override func setProgress(_ point:CGPoint){
        contentContainer.layer?.position = CGPoint(point.x,0)//moves the contentContainer (locks it into hor movement)
    }
    override func onScrollWheelChange(_ event: NSEvent) {
        super.onScrollWheelChange(event)
        let x = moverGroup.result.x
        
        let absX = abs(x)
        if absX >= prevX + 100 {/*only redraw at every 100px threshold*/
            //Swift.print("if x:\(x)")
            tick(x)
            prevX = absX
        }else if absX < prevX{
            //Swift.print("else if x: \(x)")
            tick(x)
            prevX = absX - 100
        }
    }
    /**
     * This method is only called on every 100th px threshold
     */
    private func tick(_ x:CGFloat){
        //Swift.print("Tick: \(x)")
        let minY = Utils.calcMinY(x: x, width: width, points:points)
        //Swift.print("⚠️️ minY: " + "\(minY))")
        if let prevMinY = self.prevMinY, prevMinY != minY {/*Skips anim if the graph doesn't need to scale*/
//            initAnim()/*Initiates the animation*/
            Swift.print("🍌 Tick")
        }
        self.prevMinY = minY//set the prev anim
    }
}
extension GraphScrollView3{
    var createCustomMoverGroup:MoverGroup {//TODO: 🏀 Rename to createMoverGroup
        let setProgress = { (_ value:CGFloat,_ dir:Dir) -> Void in
            guard dir == .hor else {return}//forces hor as major direction only
            self.contentContainer.layer?.position[dir] = value
        }
        var group = MoverGroup(setProgress,self.maskSize,self.contentSize)
        group.event = (self as EventSendable).onEvent/*Add an eventHandler for the mover object, , this has no functionality in this class, but may have in classes that extends this class, like hide progress-indicator when all animation has stopped*/
        return group
    }
}



/**
 * utilities related
 */
private class Utils{
    /**
     * New
     */
    static func calcMinY(x:CGFloat, width:CGFloat, points:[CGPoint]) -> CGFloat{
        let x1:CGFloat = -1 * x/*Here we flip the x to be positive*/
        let x2:CGFloat = (-1 * x) + width
        /**/
        let minX:CGFloat = x1/*The begining of the current visible graph*/
        let maxX:CGFloat = x2/*The end of the visible range*/
        let minY:CGFloat = self.minY(minX:minX,maxX:maxX,points:points)/*Returns the smallest Y value in the visible range*/
        return minY
    }
    /**
     * Returns minY for the visible graph
     * NOTE: The visible graph is the portion of the graph that is visible at any given progression.
     * PARAM: minX: The begining of the current visible graph
     * PARAM: maxX: The end of the visible range
     */
    static func minY(minX:CGFloat,maxX:CGFloat,points:[CGPoint]) -> CGFloat {
        let yValuesWithinMinXAndMaxX:[CGFloat] = points.filter{$0.x >= minX && $0.x <= maxX}.map{$0.y}/*We gather the points within the current minX and maxX*/
        return (yValuesWithinMinXAndMaxX).min()!
    }
}
