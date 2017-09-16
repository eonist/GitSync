import Foundation
@testable import Utils

extension CommitCountDB{
    /**
     * Add commitCount for day date
     */
    func addRepo(repoId:String,date:DBDate,commitCount:Int) {//rename to addCommit
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
        static func createMonthValue(date:DBDate,commitCount:Int) -> Month{
            let dayDict:DayDict = [date.day:commitCount]
            return (month:date.month,dayDict:dayDict)
        }
        /**
         * Year
         */
        static func createYearValue(date:DBDate,commitCount:Int) -> Year{
            let month = createMonthValue(date: date, commitCount: commitCount)
            let monthDict:MonthDict = [date.month:month.dayDict]
            let year:Year = (year:date.year,monthDict:monthDict)
            return year
        }
        /**
         * Repo
         */
        static func createRepoValue(repoId:String,date:DBDate,commitCount:Int) -> Repo{
            let year:Year = createYearValue(date: date, commitCount: commitCount)
            let yearDict:YearDict = [year.year:year.monthDict]
            let repo:Repo = (repoId:repoId,year:yearDict)
            return repo
        }
        /**
         * ⚠️️
         */
        static func addYear(yearDict:inout YearDict,date:DBDate,commitCount:Int){
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
        private static func addMonth(monthDict:inout MonthDict,date:DBDate,commitCount:Int){
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
        static func addDay(dayDict:inout DayDict,date:DBDate,commitCount:Int){
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
