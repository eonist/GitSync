import Foundation
@testable import Utils

extension CommitCountDB{
    /**
     * New
     */
    func addRepo(repoId:String,commitCounts:[(date:YMD,commitCount:Int)]){
        commitCounts.forEach {//👈 then do this one with resulting arr
            self.addRepo(repoId: repoId, date: $0.date, commitCount: $0.commitCount)
        }
    }
    /**
     * Add commitCount for day date
     */
    func addRepo(repoId:String,date:YMD,commitCount:Int) {//rename to addCommit
        if repos[repoId] != nil {
            Utils.addYear(yearDict:&repos[repoId]!,date:date,commitCount:commitCount)
        }else{
            let repoVal = Utils.createRepoValue(repoId: repoId, date: date, commitCount: commitCount)
            repos[repoId] = repoVal.year
        }
    }
    /**
     * Removes for repoId
     */
    func remove(repoId:String){
        repos.removeValue(forKey: repoId)
    }
    //
    //add a way to remove
}

extension CommitCountDB{
    class Utils{
        /**
         * Month
         */
        static func createMonthValue(date:YMD,commitCount:Int) -> Month{
            let dayDict:DayDict = [date.day:commitCount]
            return (month:date.month,dayDict:dayDict)
        }
        /**
         * Year
         */
        static func createYearValue(date:YMD,commitCount:Int) -> Year{
            let month = createMonthValue(date: date, commitCount: commitCount)
            let monthDict:MonthDict = [date.month:month.dayDict]
            let year:Year = (year:date.year,monthDict:monthDict)
            return year
        }
        /**
         * Repo
         */
        static func createRepoValue(repoId:String,date:YMD,commitCount:Int) -> Repo{
            let year:Year = createYearValue(date: date, commitCount: commitCount)
            let yearDict:YearDict = [year.year:year.monthDict]
            let repo:Repo = (repoId:repoId,year:yearDict)
            return repo
        }
        /**
         * ⚠️️
         */
        static func addYear(yearDict:inout YearDict,date:YMD,commitCount:Int){
            if yearDict[date.year] != nil {
                addMonth(monthDict: &yearDict[date.year]!, date: date, commitCount: commitCount)
            }else{
                let year:Year = createYearValue(date: date, commitCount: commitCount)
                yearDict[date.year] = year.monthDict
            }
        }
        /**
         * ⚠️️
         */
        private static func addMonth(monthDict:inout MonthDict,date:YMD,commitCount:Int){
            //recently edited ⚠️️
            if monthDict[date.month] != nil {
                addDay(dayDict: &monthDict[date.month]!, date: date, commitCount: commitCount)
            }else{
                let month:Month = createMonthValue(date: date, commitCount: commitCount)
                monthDict[date.month] = month.dayDict
            }
            
        }
        /**
         * ⚠️️
         */
        static func addDay(dayDict:inout DayDict,date:YMD,commitCount:Int){
            if let commitCountVal:Int = dayDict[date.day] {
                Swift.print("commitCount exists")
                dayDict[date.day] = commitCountVal + commitCount
            }else {
                Swift.print("commitCount doesnt exists")
                dayDict[date.day] = commitCount
            }
        }
    }
}
