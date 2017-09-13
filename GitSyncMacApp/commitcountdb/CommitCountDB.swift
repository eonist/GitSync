import Foundation
@testable import Utils
/**
 * DataBase for git commit count (so that graphs can be drawn from the data, querrying git is to cpu intensive for visualization)
 * TODO: ⚠️️ Figure out a sceheme to store the repo commit stats in database where it's also removable if repos are removed etc. Also filtering repos 👈👈👈
 * TODO: ⚠️️ No cached data at first
 */
class CommitCountDB {
    typealias DateValue = (year:Int,month:Int,day:Int)
    //get rid of day, use dict,ninstead of arr to simplify adding. etc. start v2 of this class instead
    //look at the old commit graph db and look at commitlist db. how they are designed
    //you need to cache totals at each level 🚫
    
    typealias DayValue = (day:Int,value:Int)
    typealias MonthValue = (month:Int,value:[DayValue])
    typealias YearValue = (year:Int,value:[MonthValue])
    typealias RepoValue = [/*id:*/String:/*value:*/[YearValue]]
    var repos:RepoValue = [:]
    init(){
//        let id:String = "RepoA"/*repoID*/
//        let year:Int = 2015
//        let month:Int = 3
//        let day:Int = 21
//        let commitCount:Int = 10//for a day
//        let dayValue:DayValue = (day:day, value:commitCount)
//        let monthValue:MonthValue = (month:month,value:[dayValue])
//        let yearValue:YearValue = (year:year, value:[monthValue])
//        let repoValue:RepoValue = [/*id:*/id:/*value:*/[yearValue]]
//        self.repos = repoValue
    }
}

extension CommitCountDB{
    /**
     * Get commit count for repo id
     */
    func commitCount(repoID:String,from:Date,to:Date)-> Int{
        return 0
    }
    /**
     * Get commit coint for all repos
     */
    func commitCountForAll(from:Date,to:Date) -> Int {
        return 0
    }
    enum DBError: Error {
        case repoDoesntExist
        case yearDoesntExist
        case monthDoesntExist
        case dayDoesntExist
    }
    /**
     *
     */
    func createRepoValue(repoId:String,dateValue:DateValue,commitCount:Int)->RepoValue{
        let yearValue:YearValue = createYearValue(dateValue: dateValue, commitCount: commitCount)
        let repoValue:RepoValue = [/*id:*/repoId:/*value:*/[yearValue]]
        return repoValue
    }
    /**
     *
     */
    func createYearValue(dateValue:DateValue,commitCount:Int) -> YearValue{
        let monthValue = createMonthValue(month:dateValue.month,day:dateValue.day,commitCount:commitCount)
        let yearValue:YearValue = (year:dateValue.year, value:[monthValue])
        return yearValue
    }
    /**
     *
     */
    func createMonthValue(month:Int,day:Int,commitCount:Int) -> MonthValue{
        let dayValue:DayValue = (day:day, value:commitCount)
        let monthValue:MonthValue = (month:month,value:[dayValue])
        return monthValue
    }
    /**
     * Add commitCount for day date
     */
    func add(repoId:String,date:DateValue,commitCount:Int) throws {

//        guard let years:[YearValue] = repos[repoId] else{throw DBError.repoDoesntExist}
//        guard let yearIndex:Int? = try years.index(where: {$0.year == date.year}) // else {throw DBError.yearDoesntExist}
//        let matchingYear:YearValue = {
//            guard let idx = yearIndex else {throw DBError.yearDoesntExist}
//            return years[idx]
//        }()
//
////        guard let matchingMonth:MonthValue = matchingYear.value.first(where: {$0.month == date.month}) else {throw DBError.monthDoesntExist}
////        guard var matchingDay:DayValue = matchingMonth.value.first(where: {$0.day == date.day}) else {throw DBError.dayDoesntExist}
//
//        Swift.print("matchingDay.value: " + "\(matchingDay.value)")
//        matchingDay.value = commitCount
//        let dayValue:DayValue =
//        let monthValue:MonthValue = [month.string:[dayValue]]
//        let yearValue:YearValue = [year.string:[monthValue]]
        
//        _ = DictionaryModifier.merge(&self.repos, repoValue)//left.updateValue(v,forKey:k)
    }
    /**
     * Returns commit count for id and date
     */
    func commitCount(repoId:String,date:DateValue) throws -> Int{
        guard let years:[YearValue] = repos[repoId] else{throw DBError.repoDoesntExist}
        guard let matchingYear:YearValue = years.first(where: {$0.year == date.year})  else {throw DBError.yearDoesntExist}
        guard let matchingMonth:MonthValue = matchingYear.value.first(where: {$0.month == date.month}) else {throw DBError.monthDoesntExist}
        guard let matchingDay:DayValue = matchingMonth.value.first(where: {$0.day == date.day}) else {throw DBError.dayDoesntExist}
        return matchingDay.value
    }
    /**
     * NOTE: This is used when adding new commit data to the db
     */
    func lastCommit(repoId:String) throws -> (date:DateValue,commitCount:Int){
        guard let years:[YearValue] = repos[repoId] else{throw DBError.repoDoesntExist}
        guard let lastYear:YearValue = years.last else {throw DBError.yearDoesntExist}
        guard let lastMonth:MonthValue = lastYear.value.last else {throw DBError.monthDoesntExist}
        guard let lastDay:DayValue = lastMonth.value.last else {throw DBError.dayDoesntExist}
        //
        let lastCommitDate:DateValue = (year:lastYear.year,month:lastMonth.month,day:lastDay.day)
        let commitCount:Int = lastDay.value
        return (date:lastCommitDate,commitCount:commitCount)
    }
}


class TempA{
    var arr:[String:(id:String,value:[String])] = [:]
}
