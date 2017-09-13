import Foundation
@testable import Utils

extension CommitCountDB{
    /**
     * Commits for  each year for all repos
     */
    var yearCounts:[Int:Int]{
        var commits:[Int:Int] = [:]
        repos.forEach{ repo in
            let repoId:String = repo.key
            repo.value.forEach { year in
                let yearKey:Int = year.key
                if let commitCountForYear:Int = commitCount(repoId: repoId, year: yearKey) {
                    if let commitsVal = commits[yearKey] {//Already exists
                        commits[yearKey] = commitsVal + commitCountForYear
                    } else {
                        commits[yearKey] = commitCountForYear
                    }
                }
            }
        }
        //🏀
        //min and max year
        //diff of min and max
        //create array a count of diff with zero values
        //dict.forEach {idx = $0.key-min;arr[idx] = $0.val}
        //lets use DP2 for this 👈
        //THIS COULD BE USED FOR COMMITLIST 💥 or inspire something better
            //Graph iterates over array
            //you need
        //🎉
        
        return commits
    }
    //commits for each month for all repos👈
    
    //commit count for each day for all repos👈
}
/**
 * Holds commitCount for each time unit (year,month,day) (can work for many repos or singular repos)
 * EXAMPLE: let commitCountDP = CommitCountDP(commitCount:[:])
 */
class CommitCountDP {
    var commitCount:[Int:Int]
    lazy var min:Int = commitCount.keys.min() ?? 0
    lazy var max:Int = commitCount.keys.max() ?? 0
    var count: Int {return max - min + 1}
    init(commitCount:[Int:Int]) {
        self.commitCount = commitCount
    }
    func item(at: Int) -> Int? {
        let key:Int = min + at
        return commitCount[key]
    }
}
