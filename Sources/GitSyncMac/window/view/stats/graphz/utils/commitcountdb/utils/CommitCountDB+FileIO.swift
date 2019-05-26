import Foundation
@testable import Utils


extension CommitCountDB {
    class FileIO{
        /**
         * Saves db to drive
         */
        static func save(db:CommitCountDB){
            let jsonFriendlyDict = db.jsonFriendlyDict
//        Swift.print("jsonFriendlyDict: " + "\(jsonFriendlyDict)")
            //convert to json string
            guard let str = JSONParser.str(dict:jsonFriendlyDict) else {return}
//            Swift.print("str: " + "\(str)")
            let filePath:String = Config.Bundle.commitCountsURL.tildePath
            _ = str.write(filePath: filePath)
        }
        /**
         * Opens db from drive
         */
        static func open() -> CommitCountDB{
            let filePath:String = Config.Bundle.commitCountsURL.tildePath
            guard let content:String = filePath.content else{fatalError("err")}
            guard let jsonDict:[String:Any] = content.json as? [String:Any] else {fatalError("err")}
            //jsonDict.forEach{Swift.print("$0.key: " + "\($0.key)")}
            let commitCountDb = CommitCountDB.commitCountDb(jsonDict: jsonDict)//convert to commitdb friendly dict
//            Swift.print("commitCountDb.repos.count: " + "\(commitCountDb.repos.count)")
//            CommitCountDPUtils.describeMonth(commitDb:commitCountDb)
            return commitCountDb
        }
    }
}
