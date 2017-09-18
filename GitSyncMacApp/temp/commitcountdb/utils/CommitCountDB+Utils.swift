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
                if let commitCountForYear:Int = yearCount(repoId: repoId, year: yearKey) {
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
     * TODO: ⚠️️ the pad stuff is now a convenience call in YMD, use that instead
     */
    var monthCounts:[Int:Int]{
        var commits:[Int:Int] = [:]
        //each repo
         //[2016:[12:26]]
        repos.forEach{ repo in
            repo.value.forEach { year in//each year
                year.value.forEach{ month in//each month
                    if let commitCountForMonth:Int = monthCount(repoId:repo.key, year:year.key, month:month.key) {
                        let monthKeyStr:String = StringParser.pad(value: month.key, padCount: 2, padStr: "0")//pads the month to always look like: "02" instead of "2"
                        let key:Int = (year.key.string + monthKeyStr).int//2016 + 2 = 201602 (makes the key sortable, and min and max works)
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
    /**
     * Output: [[2016'02'14:5]]
     * TODO: ⚠️️ the pad stuff is now a convenience call in YMD, use that instead
     */
    var dayCounts:[Int:Int]{
        var commits:[Int:Int] = [:]
        repos.forEach{ repo in//each repo
            repo.value.forEach { year in//each year
                year.value.forEach{ month in//each month
                    month.value.forEach{ day in//each day
                        if let commitCountForDay:Int = dayCount(repoId:repo.key,date:.init(year:year.key,month:month.key,day:day.key)) {
                            let monthKeyStr:String = StringParser.pad(value: month.key, padCount: 2, padStr: "0")//pads the month to always look like: "02" instead of "2"
                            let dayKeyStr:String = StringParser.pad(value: day.key, padCount: 2, padStr: "0")
                            let key:Int = (year.key.string + monthKeyStr + dayKeyStr).int//(makes the key sortable, and min and max works)
                            if let commitsVal = commits[key] {//Already exists
                                commits[key] = commitsVal + commitCountForDay
                            } else {
                                commits[key] = commitCountForDay
                            }
                        }
                    }
                }
            }
        }
        return commits
    }
    
}
