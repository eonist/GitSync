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
     *
     */
    func remove(){
        
    }
    //
    //add a way to remove
}

