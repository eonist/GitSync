import Foundation
@testable import Utils
@testable import Element
@testable import GitSyncMac

class GraphZ:Element{
    lazy var timeBar:TimeBarZ = {
        let listConfig = List5.Config.init(itemSize: CGSize(124,24), dp: DP.init(), dir: .hor)
        let timeBar = TimeBarZ.init(graphZ:self,config: listConfig, size: CGSize(getWidth(),24))/*Creates the TimeBar*/
        return timeBar
    }()
    lazy var graphArea:GraphAreaZ = GraphAreaZ(graphZ: self,size: CGSize(0,0))
    /**
     * TODO: ⚠️️ db should get its events here and then forward them to timebar and grapharea, the eventHandlers get set in TimeBar so you need to set the event handler after timebar is created and point it here instead.
     */
    lazy var dp:GraphZDP = {
//        Swift.print("commitDb.monthCounts: " + "\(commitDb.monthCounts)")
        let dp = GraphZDP.init(timeType: .day, commitCountDB: mockDB)
//        CommitCountDPUtils.describeDay(commitDb:mockDB)
        return dp
    }()
    let db:CommitCountDB
    
    init(db:CommitCountDB,size: CGSize, id: String? = nil) {
        self.db = db
        super.init(size: size, id: id)
    }
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func resolveSkin() {
        super.resolveSkin()
        Swift.print("getWidth(): " + "\(getWidth())")
//        addSubview(timeBar)
        addSubview(graphArea)
    }
    override func getClassType() -> String {
        return "\(GraphX.self)"
    }
}
extension GraphZ{
    var mockDB:CommitCountDB {
//        let commitDb = CommitCountDB.FileIO.open()
        
        let commitDb = CommitCountDB()
        commitDb.addRepo(repoId: "RepoB", date: .init(year:2014,month:3,day:7), commitCount: 13)
        commitDb.addRepo(repoId: "RepoA", date: .init(year:2015,month:3,day:3), commitCount: 20)
        commitDb.addRepo(repoId: "RepoA", date: .init(year:2015,month:6,day:13), commitCount: 30)
        commitDb.addRepo(repoId: "RepoA", date: .init(year:2014,month:7,day:17), commitCount: 5)
        commitDb.addRepo(repoId: "RepoB", date: .init(year:2014,month:7,day:20), commitCount: 16)
        commitDb.addRepo(repoId: "RepoB", date: .init(year:2014,month:5,day:20), commitCount: 4)
        commitDb.addRepo(repoId: "RepoB", date: .init(year:2014,month:11,day:20), commitCount: 13)
        commitDb.addRepo(repoId: "RepoA", date: .init(year:2014,month:1,day:4), commitCount: 5)
        return commitDb
    }
}
