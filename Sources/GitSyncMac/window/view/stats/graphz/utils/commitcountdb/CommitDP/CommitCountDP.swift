import Foundation
@testable import Utils

/**
 * Holds commitCount for each time unit (year,month,day) (can work for many repos or singular repos)
 * EXAMPLE: let commitCountDP = CommitCountDP(commitCount:[:])
 */
class CommitCountDP:CommitCountDPKind{//this works for year as well
    var commitCount:[Int:Int]
    lazy var min:Int = commitCount.keys.min() ?? {fatalError("err: commitCount.count: \(commitCount.count)")}()
    lazy var max:Int = commitCount.keys.max() ?? {fatalError("err: commitCount.count: \(commitCount.count)")}()
    var count: Int {return max - min + 1}
    init(commitCount:[Int:Int]) {
        self.commitCount = commitCount
    }
    func item(at: Int) -> Int? {
        let key:Int = min + at
        return commitCount[key]
    }
    func item(at:Int)->(commitCount:Int?,ymd:YMD){
        let key:Int = min + at
        let commitCount:Int? = self.commitCount[key]
        let ymd:YMD = YMD.init(year: key, month: 1, day: 1)
        return (commitCount:commitCount,ymd:ymd)
    }
    //implement item(at)->(commitCount:Int,ymd:YMD) 🏀
}


