import Cocoa
@testable import Utils
@testable import Element
/**
 * A Graph that modulates the graph while you scroll
 */
class GraphAreaZ:Element,GraphAreaKind {
    lazy var scrollView:GraphScrollView5 = createScrollView()
    lazy var points:[CGPoint] = createCGPoints()//rename to curPoints ⚠️️
    var vValues:[Int]?
    lazy var graphDots:[Element] = createGraphPoints()
    lazy var graphLine:GraphLine = createGraphLine()
    var contentContainer:Element {return scrollView.contentContainer}/*contains dots and line*/
    var prevPoints:[CGPoint]?/*interim var*/
    let graphZ:GraphZ
    let visibleCount:Int = 7
    func item(at: Int) -> Int? {//this is just for compliance, this class is deprecated
        return graphZ.dp.item(at:at)
    }
    var count: Int {return graphZ.dp.count}
//    var count: Int {return graphZ.dp.count.clip(self.visibleCount-1, graphZ.dp.count) }/*Tot count of all items in dp*///we clip it to avoid visual bugs. -1 strangly enough works.
    lazy var maxCommitCount:Int = {graphZ.dp.dp.commitCount.values.max() ?? {fatalError("err")}()}()//max commitCount in the entire dp

    init(graphZ:GraphZ, size:CGSize, id:String? = nil) {
        self.graphZ = graphZ
        super.init(size: size, id: id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        createUI()
    }
    /**
     * Creates the UI Components
     */
    func createUI(){
        _ = points
        _ = scrollView
        _ = contentContainer
        contentContainer.addSubview(graphLine)
        _ = graphDots
//        updateGraph()
    }
    override func getClassType() -> String {
        return "GraphArea"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

