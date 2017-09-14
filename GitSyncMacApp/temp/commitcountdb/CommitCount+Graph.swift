import Foundation
@testable import Utils

extension CommitCountDB{
    /**
     * Commits for  each year for all repos
     * OUTPUT: [[2015:21],[2016:48],[2017:12]]
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
        return commits
    }
    /**
     * What will the output look like 🤔
     * Output: ["201602":45]
     */
    var monthCount:[Int:Int]{
        var commits:[Int:Int] = [:]
        //each repo
         //[2016:[12:26]]
        repos.forEach{ repo in
            let repoId:String = repo.key
            repo.value.forEach { year in//each year
                let yearKey:Int = year.key
                year.value.forEach{ month in//each month
                    let monthKey:Int = month.key
                    if let commitCountForMonth:Int = commitCount(repoId:repoId, year:yearKey, month:monthKey) {
                        let monthKeyStr:String = StringParser.pad(value: monthKey, padCount: 2, padStr: "0")//pads the month to always look like: "02" instead of "2"
                        let key:Int = (yearKey.string + monthKeyStr).int//2016 + 2 = 201602 (makes the key sortable, and min and max works)
                        if let commitsVal = commits[key] {//Already exists
                            commits[key] = commitsVal + commitCountForMonth
                        } else {
                            commits[key] = commitCountForMonth
                        }
                    }
                }
            }
        }
        return commits
    }
    //commits for each month for all repos👈
    
    //commit count for each day for all repos👈
    
    //count: ((year.max - year.min) * 12) - (month.max - month.min)
    
    //for days you have to add two zeros etc. there is a utils method for this. called paddding or something. use that 👌
}
protocol CommitCountDPKind{
    var commitCount:[Int:Int] {get}
    var min:Int {get}
    var max:Int {get}
    var count:Int {get}
}
/**
 * Holds commitCount for each time unit (year,month,day) (can work for many repos or singular repos)
 * EXAMPLE: let commitCountDP = CommitCountDP(commitCount:[:])
 */
class CommitCountDP:CommitCountDPKind{//this works for year as well
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
class MonthCommitDP:CommitCountDP{//month
    lazy var minYear:Int = min.string.subStr(0, min.string.count - 2).int//201602 -> 2016
    lazy var minMonth:Int = min.string.subStr(min.string.count - 2, min.string.count).int
    /**
     * Returns graph value for month offset
     */
    override func item(at: Int) -> Int? {
        let yearAndMonth = self.yearAndMonth(at:at)
        let year:Int = yearAndMonth.year
        let month:Int = yearAndMonth.month
        let key:Int = (year.string + month.string).int
        return commitCount[key]
    }
    func yearAndMonth(at:Int) -> (year:Int,month:Int){
        let monthOffset:Int = at % 12//leftOver
        let yearOffset:Int = (at - monthOffset) / 12
        let year:Int = self.minYear + yearOffset
        let month:Int = self.minMonth + monthOffset
        return (year,month)
    }
    
}
/**
 * [[2016'02'14:5]]
 * basically you use substring backwards. So day is .count - 2 until count and month is .count -4 until count -2, year is whatever is left
 */
class DayCommitDP{
    //with day you need to use the date class to offset min and max
        //see old class for this
}





