import Foundation
@testable import Utils

extension CommitCountDB{
    struct DBDate {let year:Int,month:Int}
    typealias MonthDict = [/*month*/Int:/*total commit count that month*/Int]
    typealias YearDict = [/*year*/Int:/*month*/MonthDict]
    typealias Year = (year:Int,monthDict:MonthDict)
    typealias Repo = (repoId:String,year:YearDict)
}

