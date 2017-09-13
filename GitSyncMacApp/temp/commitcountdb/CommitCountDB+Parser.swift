import Foundation
@testable import Utils

extension CommitCountDB{

    /**
     *
     */
    func commitCountForMonth(repoId:String,date:DBDate) -> Int? {
        return repos[repoId]?[date.year]?[date.month]
    }
    /**
     * Tot commitCount for repo
     */
    func commitCount(repoId:String) -> Int?{
        guard let yearDict:YearDict = repos[repoId] else {return nil}
        return yearDict.values.reduce(0) { (acc:Int, monthDict:MonthDict) in
            return monthDict.values.reduce(0) {
                return $0 + $1
            }
        }
    }
    /**
     * Tot commitCount for repo in year
     */
    func commitCount(repoId:String,year:Int) ->Int? {
        guard let yearDict:YearDict = repos[repoId] else {return nil}
        guard let monthDict:MonthDict = yearDict[year] else {return nil}
        return monthDict.values.reduce(0) {
            return $0 + $1
        }
    }
    /**
     * tot commit count for repo in year in month
     */
    func commitCount(repoId:String,year:Int,month:Int) ->Int?{
        guard let yearDict:YearDict = repos[repoId] else {return nil}
        guard let monthDict:MonthDict = yearDict[year] else {return nil}
        guard let commitCount:Int = monthDict[month] else {return nil}
        return commitCount
    }
    /**
     *
     */
    func commitCount(repoId:String,date:DBDate){
        //complete this when you add day
    }
    /**
     * Returns the last commit date for a repo
     */
    func lastCommitDate(repoId:String) -> DBDate?{
        guard let repo = repos[repoId] else {return nil}
        guard let lastYear:Int = repo.keys.max() else {return nil}
        guard let lastMonth:Int = repo.keys.max() else {return nil}
        //add day when that is included
        return DBDate.init(year: lastYear, month: lastMonth)
    }
    
    /**
     * CommitCount for all repos in a speccific year in a speccific month
     * you can also do it for year, or day or even for every month etc.
     */
    func commitCount(year:Int,month:Int) -> Int{
        return repos.keys.reduce(0) {
            guard let commitCount = commitCount(repoId: $1, year: year, month: month) else {return $0}
            return $0 + commitCount
        }
    }
}
