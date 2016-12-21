import Foundation
//1. you create many Operations that store Task and Pipe
//2. you then fire them of at once and listen to the last operation to complete
//3. when the last operation completes you loop thorugh the operations to retrive the data

class CommitDBUtils {
    /**
     *
     */
    static func refresh(commitDB:CommitDB){
        //You loop the repos
            //find the range of commits to add to CommitDB for this repo
        if(commitDB.sortedArr.count >= 100){
            let lastDate = commitDB.sortedArr.last!.sortableDate
            //range = now..lastDate in the repo (date based) Needs --> 🔬 (how does querying for date ranges in git work)
            
        }else {//< 100
            
        }
    }
}
