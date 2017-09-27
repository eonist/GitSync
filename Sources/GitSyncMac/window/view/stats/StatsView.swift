import Foundation
@testable import Element
@testable import Utils

class StatsView:Element,Closable{
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        createGraph()
    }
    func close() {
        Swift.print("Close StatsView")
        self.removeFromSuperview()
    }
    /**
     *
     */
    func createGraph(){
        let db:CommitCountDB = CommitCountDB.FileIO.open()//reads the cached CommitCount data
        Swift.print("🍏 db.repos.count: " + "\(db.repos.count)")
        //
        let repoList:[RepoItem] = RepoUtils.repoListFlattenedOverridden
        guard let first = repoList.first else {fatalError("err")}
        let subset = repoList//[first]//test with 1 first
        //
        let commitCounter = CommitCounter2()

        func onComplete(){
//          CommitCountDPUtils.describeMonth(commitDb:commitDb)
//          CommitCountDPUtils.describeDay(commitDb:commitDb)
            let size:CGSize = CGSize(getWidth(),getHeight())
            let graph = GraphZ(db:db,size:size,id:nil)
            addSubview(graph)//➡️️
            CommitCountDB.FileIO.save(db:db)//this should be called on app exit and statsWin.close
        }
        commitCounter.update(commitDB:db, repoList:subset, onComplete: onComplete)//⬅️️
    }
}
