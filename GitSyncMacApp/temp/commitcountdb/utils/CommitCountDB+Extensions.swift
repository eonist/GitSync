import Foundation
@testable import Utils

extension CommitCountDB{
    //Dict
    typealias DayDict = [/*Day*/Int:/*totalCommits that day*/Int]
    typealias MonthDict = [/*month*/Int:/*total commit count that month*/DayDict]
    typealias YearDict = [/*year*/Int:/*month*/MonthDict]
    //Tuples
    typealias Month = (month:Int,dayDict:DayDict)
    typealias Year = (year:Int,monthDict:MonthDict)
    typealias Repo = (repoId:String,year:YearDict)
}
//
extension CommitCountDB{
    var jsonFriendlyDict:[String:Any] {
        func convert<Key, Value>(dict: [Key: Value]) -> [String:Any]{
            var retVal:[String:Any] = [:]
            dict.forEach {
                let keyStr:String = "\($0.key)"
//                Swift.print("keyStr: " + "\(keyStr)")
                let dictItem = $0
                let val:Any = {
                    if dictItem.value is Dictionary<Int,Any> {//you could use reflection but its just two different dicts so
                        return convert(dict: dictItem.value as! [Int:Any])
                    }else if dictItem.value is Dictionary<String,Any>{
                        return convert(dict: dictItem.value as! [String:Any])
                    }else{
                        return dictItem.value
                    }
                }()
                retVal[keyStr] = val
            }
            return retVal
        }
        return convert(dict:repos)
    }
    /**
     * Since json comes back with string keys, we need to convert some of these to Int keys
     */
    static func commitCountDb(jsonDict:[String:Any])-> CommitCountDB{
        let repos:[String:YearDict] = Converter.repos(jsonDict:jsonDict)
        return .init( repos: repos)
    }
}
extension CommitCountDB{
    class Converter{
        static func days(monthVal:(key:String,value:Any)) -> DayDict{
            guard let dayDict:Dictionary<String,Any> = monthVal.value as? Dictionary<String,Int> else {fatalError("not correct dict type")}
            return dayDict.reduce([:]) { (acc:[Int:Int],dayVal) in
                var accDict:[Int:Int] = acc
                accDict[dayVal.key.int] = dayVal.value as? Int ?? {fatalError("must be int")}()
                return accDict
            }
        }
        static func months(yearVal:(key:String,value:Any)) -> MonthDict{
            guard let monthDict:Dictionary<String,Any> = yearVal.value as? Dictionary<String,Any> else {fatalError("not correct dict type")}
            return monthDict.reduce([:]){ (acc:[Int:DayDict],monthVal) in
                var accDict:[Int:DayDict] = acc
                accDict[monthVal.key.int] = {
                    return days(monthVal:monthVal)
                }()
                return accDict
            }
        }
        static func years(repoVal:(key:String,value:Any)) -> YearDict{
            guard let yearsDict:Dictionary<String,Any> = repoVal.value as? Dictionary<String,Any> else {fatalError("not correct dict type")}
            return yearsDict.reduce([:]) { (acc:[Int:MonthDict],yearVal) in
                var accDict:[Int:MonthDict] = acc
                accDict[yearVal.key.int] = {
                    return months(yearVal: yearVal)
                }()
                return accDict
            }
        }
        static func repos(jsonDict:[String:Any]) -> [String:YearDict] {
            return jsonDict.reduce([:]) { (acc:[String:YearDict],repoVal) in
                var accDict:[String:YearDict] = acc
                accDict[repoVal.key] = {
                    return years(repoVal:repoVal)
                }()
                return accDict
            }
        }
    }
} 