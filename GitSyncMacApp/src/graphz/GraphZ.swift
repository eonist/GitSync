import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac

class GraphZ:Element{
    /*Components*/
    lazy var timeBar:TimeBarZ = TimeBarZ(graphZ:self,size:CGSize(getWidth(),0)) /*Creates the TimeBar*///move to extension ⚠️️
    lazy var valueBar:ValueBarZ = ValueBarZ(size:CGSize(0,0),id:nil)/*Creates the ValueBar*/
    lazy var graphArea:GraphAreaZ = GraphAreaZ(graphZ: self,size: CGSize(0,0))
    /**
     * TODO: ⚠️️ db should get it's events here and then forward them to timebar and grapharea, the eventHandlers get set in TimeBar so you need to set the event handler after timebar is created and point it here instead.
     */
    lazy var dp:GraphZDP = GraphZDP.init(timeType: .month, commitCountDB: db)
    let db:CommitCountDB
    //
    init(db:CommitCountDB,size: CGSize, id: String? = nil) {
        self.db = db
        super.init(size: size, id: id)
    }
    required init(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func scrollWheel(with event: NSEvent) {
        super.scrollWheel(with: event)
        (timeBar.handler as? ScrollHandler)?.scroll(event)
    }
    override func resolveSkin() {
        super.resolveSkin()
        Swift.print("getWidth(): " + "\(getWidth())")
        addSubview(valueBar)
        addSubview(graphArea)
        addSubview(timeBar)
        let maxValue:Int = graphArea.vValues!.max()!
        update(maxValue: maxValue)//updates valueBar and dateIndicator
    }
    override func getClassType() -> String {
        return "\(GraphX.self)"
    }
}

