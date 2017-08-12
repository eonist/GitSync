import Foundation
@testable import Utils

struct ProcessedCommitData {
    let date:Date,relativeDate:String,descendingDate:String,body:String,subject:String,hash:String,author:String
}
extension ProcessedCommitData{
    func dict(_ repoTitle:String,_ commitData:CommitData) -> [String:String] {
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
extension CommitData{
    /**
     * ProcessedCommitData
     * NOTE: conforms dates, msg-desc, msg-title,
     */
    func processCommitData(_ repoTitle:String)->ProcessedCommitData{
        let date:Date = GitDateUtils.date(self.date)
        //Swift.print("date.shortDate: " + "\(date.shortDate)")
        let relativeTime:(value:Int,type:String) = DateParser.relativeTime(Date(),date)[0]
        let relativeDate:String = relativeTime.value.string + relativeTime.type/*create date like 3s,4m,5h,6w,2y*/
        let descendingDate:String = DateParser.descendingDate(date)
        let compactBody:String = GitLogParser.compactBody(self.body)/*Compact the commit msg body*/
        let subject:String = StringParser.trim(self.subject, "'", "'")
        return .init(date: date,relativeDate: relativeDate,descendingDate: descendingDate,body: compactBody,subject: subject,hash: self.hash,author: self.author)
    }
}
