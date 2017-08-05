import Foundation

struct CommitMessage{
    var title:String
    var description:String
    init(_ title:String,_ desc:String){
        self.title = title
        self.description = desc
    }
}
extension CommitMessage{
    static func commitMessage(_ localRepoPath:String) -> CommitMessage? {
        let statusList:[[String:String]] = StatusUtils.generateStatusList(localRepoPath)//get current status
        //Swift.print("statusList.count: " + "\(statusList.count)")
        if (statusList.count > 0) {
            //Swift.print("doCommit().there is something to add or commit")
            StatusUtils.processStatusList(localRepoPath, statusList) //process current status by adding files, now the status has changed, some files may have disapared, some files now have status as renamed that prev was set for adding and del
            let title = CommitMessageUtils.sequenceCommitMsgTitle(statusList) //sequence commit msg title for the commit
            //Swift.print("commitMsgTitle: " + "\(title)")
            let desc = CommitDescUtils.sequenceDescription(statusList)//sequence commit msg description for the commit
            //Swift.print("commitMsgDesc: >" + "\(desc)" + "<")
            let commitResult = GitModifier.commit(localRepoPath, (title,desc))//🌵 commit
            _ = commitResult
            //Swift.print("commitResult: " + "\(commitResult)")
            return CommitMessage(title,desc)/*return true to indicate that the commit completed*/
        }else{
            //Swift.print("nothing to add or commit")
            return nil/*break the flow since there is nothing to commit or process*/
        }
    }
}
