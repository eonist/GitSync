import Foundation
@testable import Utils

extension CommitCountDB{
    struct DBDate {let year:Int,month:Int}
    typealias MonthDict = [/*month*/Int:/*total commit count that month*/Int]
    typealias YearDict = [/*year*/Int:/*month*/MonthDict]
    typealias Year = (year:Int,monthDict:MonthDict)
    typealias Repo = (repoId:String,year:YearDict)
    
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

