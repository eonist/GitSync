import Cocoa
@testable import Utils
@testable import Element

class GraphScrollView2:ElasticScrollerView5 {
    private var graphScrollerHandler:GraphScrollerHandler {return handler as! GraphScrollerHandler}//move this to extension somewhere
    override lazy var handler:ProgressHandler = GraphScrollerHandler(progressable:self)
    //
    override var contentSize:CGSize {return CGSize(100*19,super.getHeight())}
    override var itemSize:CGSize {return CGSize(24,24)}
    //
    var prevX:CGFloat = -100
    var prevPoints:[CGPoint]?/*Interim var*/
    var newPoints:[CGPoint]?
    var animator:NumberSpringer?
    var prevMinY:CGFloat?//prevMinY to avoid calling start anim
    var graphArea:GraphAreaX
    init(graphArea:GraphAreaX, size: CGSize, id: String? = nil) {
        Swift.print("GraphScrollView2")
        self.graphArea = graphArea
        super.init(size: size, id: id)
    }
    
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    //var animationCue:Animator?
    override func resolveSkin() {
        super.resolveSkin()
        layer!.masksToBounds = true
    }
    override func getClassType() -> String {
        return "\(GraphScrollView.self)"
    }
}



