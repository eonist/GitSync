import Foundation
@testable import Utils

/**
 * Holds commitCount for each time unit (year,month,day) (can work for many repos or singular repos)
 * EXAMPLE: let commitCountDP = CommitCountDP(commitCount:[:])
 */
class CommitCountDP:CommitCountDPKind{//this works for year as well
    var commitCount:[Int:Int]
    lazy var min:Int = commitCount.keys.min() ?? {fatalError("err")}()
    lazy var max:Int = commitCount.keys.max() ?? {fatalError("err")}()
    var count: Int {return max - min + 1}
    init(commitCount:[Int:Int]) {
        self.commitCount = commitCount
    }
    func item(at: Int) -> Int? {
        let key:Int = min + at
        return commitCount[key]
    }
}
