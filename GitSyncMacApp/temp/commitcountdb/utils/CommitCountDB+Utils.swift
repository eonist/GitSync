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
    /**
     * Output: [[2016'02'14:5]]
     */
    var dayCount:[Int:Int]{
        var commits:[Int:Int] = [:]
        repos.forEach{ repo in
            let repoId:String = repo.key
            repo.value.forEach { year in//each year
                let yearKey:Int = year.key
                year.value.forEach{ month in//each month
                    let monthKey:Int = month.key
                    let monthKeyStr:String = StringParser.pad(value: monthKey, padCount: 2, padStr: "0")
                    month.values.forEach{ month in
                       
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






