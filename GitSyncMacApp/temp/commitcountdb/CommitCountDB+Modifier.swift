import Foundation
@testable import Utils

extension CommitCountDB{
    /**
     * Add commitCount for day date
     */
    func addRepo(repoId:String,date:DBDate,commitCount:Int) {
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
         * Year
         */
        static func createYearValue(date:DBDate,commitCount:Int) -> Year{
            let monthVal:MonthDict = [date.month:commitCount]
            let yearVal:Year = (year:date.year,monthDict:monthVal)
            return yearVal
        }
        /**
         * Repo
         */
        static func createRepoValue(repoId:String,date:DBDate,commitCount:Int) -> Repo{
            let year:Year = createYearValue(date: date, commitCount: commitCount)
            let yearDict:YearDict = [year.year:year.monthDict]
            let repoVal:Repo = (repoId:repoId,year:yearDict)
            return repoVal
        }
        /**
         *
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
         *
         */
        private static func addMonth(monthDict:inout MonthDict,date:DBDate,commitCount:Int){
            if let commitCountVal:Int = monthDict[date.month] {
                Swift.print("commitCount exists")
                monthDict[date.month] = commitCountVal + commitCount
            }else {
                Swift.print("commitCount doesnt exists")
                monthDict[date.month] = commitCount
            }
        }
    }
}
