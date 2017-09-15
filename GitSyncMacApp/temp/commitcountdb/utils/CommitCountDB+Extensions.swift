import Foundation
@testable import Utils

extension CommitCountDB{
    struct DBDate {let year:Int,month:Int,day:Int}
    typealias DayDict = [/*Day*/Int:/*totalCommits that day*/Int]
    typealias MonthDict = [/*month*/Int:/*total commit count that month*/DayDict]
    typealias YearDict = [/*year*/Int:/*month*/MonthDict]
    typealias Month = (month:Int,dayDict:DayDict)
    typealias Year = (year:Int,monthDict:MonthDict)
    typealias Repo = (repoId:String,year:YearDict)
}

extension CommitCountDB.DBDate{
    var date:Date? {return Date.createDate(self.year, self.month, self.day)}
    /**
     *
     */
    
}
