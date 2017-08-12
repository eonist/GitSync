import Foundation
@testable import Utils

struct ProcessedCommitData {
    let commitData:CommitData
    let repoTitle:String
    var date:Date {return GitDateUtils.date(commitData.date)}
    var relativeDate:String {
        let relativeTime:(value:Int,type:String) = DateParser.relativeTime(Date(),date)[0]
        return relativeTime.value.string + relativeTime.type/*create date like 3s,4m,5h,6w,2y*/
    }
    var descendingDate:String {
        return DateParser.descendingDate(date)
    }
    var body:String {
        return GitLogParser.compactBody(commitData.body)/*Compact the commit msg body*/
    }
    var subject:String {
        return StringParser.trim(commitData.subject, "'", "'")
    }
    var hash:String {
        return commitData.hash
    }
    var author:String {
        return commitData.author
    }
    /**
     * ProcessedCommitData
     * NOTE: conforms dates, msg-desc, msg-title,
     */
    init(_ commitData:CommitData, _ repoTitle:String){
        self.commitData = commitData
        self.repoTitle = repoTitle
    }
    init(rawCommitData:String,_ repoTitle:String) {
        let commitData:CommitData = CommitDataUtils.convert(raw:rawCommitData)/*Compartmentalizes the result into a Tuple*/
        self.init(commitData, repoTitle)
    }
}
/**
 * -> Dictionary<String, String>
 * TODO: Use the new CommitDataItem
 */
extension ProcessedCommitData{
    var dict:[String:String] {
        let dict = [
        CommitItem.repoName:repoTitle,
        CommitItem.contributor:self.author,
        CommitItem.title:self.subject,
        CommitItem.description:self.body,
        CommitItem.date:self.relativeDate,
        CommitItem.sortableDate:self.descendingDate,
        CommitItem.hash:self.hash,
        CommitItem.gitDate:commitData.date
        ]
        return dict
    }
}
