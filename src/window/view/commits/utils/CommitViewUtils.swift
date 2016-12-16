import Foundation

class CommitViewUtils {
    /**
     *
     */
    class func processCommitData(repoTitle:String,_ commitData:CommitData)-> Dictionary<String, String>{
        let date:NSDate = GitLogParser.date(commitData.date)
        //Swift.print("date.shortDate: " + "\(date.shortDate)")
        let relativeTime = DateParser.relativeTime(NSDate(),date)[0]
        let relativeDate:String = relativeTime.value.string + relativeTime.type/*create date like 3s,4m,5h,6w,2y*/
        //Swift.print("relativeDate: " + "\(relativeDate)")
        let descendingDate:String = DateParser.descendingDate(date)
        let compactBody:String = GitLogParser.compactBody(commitData.body)/*compact the commit msg body*/
        //Swift.print("compactBody: " + "\(compactBody)")
        let subject:String = StringParser.trim(commitData.subject, "'", "'")
        let processedCommitData:Dictionary<String, String> = ["repo-name":repoTitle,"contributor":commitData.author,"title":subject,"description":compactBody,"date":relativeDate,"sortableDate":descendingDate,"hash":commitData.hash]
        return processedCommitData
    }
}
