import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac

class GraphZ:Element{
    lazy var timeBar:TimeBarZ = {
        let listConfig = List5.Config.init(itemSize: CGSize(124,24), dp: DP.init(), dir: .hor)//the dp doesnt do anything
        let timeBar = TimeBarZ.init(graphZ:self,config: listConfig, size: CGSize(getWidth(),0))/*Creates the TimeBar*/
        return timeBar
    }()
    lazy var graphArea:GraphAreaZ = GraphAreaZ(graphZ: self,size: CGSize(0,0))
    /**
     * TODO: ⚠️️ db should get its events here and then forward them to timebar and grapharea, the eventHandlers get set in TimeBar so you need to set the event handler after timebar is created and point it here instead.
     */
    lazy var dp:GraphZDP = {
//        Swift.print("commitDb.monthCounts: " + "\(commitDb.monthCounts)")
        let dp = GraphZDP.init(timeType: .month, commitCountDB: db)
//        CommitCountDPUtils.describeDay(commitDb:mockDB)
        Swift.print("dp: " + "\(dp.count) aka numOfTimeTypeUnitesBetween min and max date")
        Swift.print("db.count: " + "\(db.count) aka tot Count in all repos")
        return dp
    }()
    let db:CommitCountDB
    
    init(db:CommitCountDB,size: CGSize, id: String? = nil) {
        self.db = db
        super.init(size: size, id: id)
    }
    required init(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func resolveSkin() {
        super.resolveSkin()
        Swift.print("getWidth(): " + "\(getWidth())")
        addSubview(timeBar)
//        addSubview(graphArea)
    }
    override func getClassType() -> String {
        return "\(GraphX.self)"
    }
}
