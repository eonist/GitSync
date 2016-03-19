import Foundation

class GitSync{
    /**
     * This method generates a git status list,and asserts if a commit is due, and if so, compiles a commit message and then tries to commit
     * Returns true if a commit was made, false if no commit was made or an error occured
     * NOTE: checks git staus, then adds changes to the index, then compiles a commit message, then commits the changes, and is now ready for a push
     * NOTE: only commits if there is something to commit
     * TODO: add branch parameter to this call
     * NOTE: this a purly local method, does not need to communicate with remote servers etc..
     */
    class func doCommit(localRepoPath:String)->Bool{
        Swift.print("doCommit()")
        let statusList = StatusUtils.generateStatusList(localRepoPath)//get current status
        Swift.print("statusList.count: " + "\(statusList.count)")
        if (statusList.count > 0) {
            Swift.print("there is something to add or commit")
            StatusUtils.processStatusList(localRepoPath, statusList) //process current status by adding files, now the status has changed, some files may have disapared, some files now have status as renamed that prev was set for adding and del
            let commitMsgTitle = CommitUtils.sequenceCommitMsgTitle(statusList) //sequence commit msg title for the commit
            Swift.print("commitMsgTitle: " + "\(commitMsgTitle)")
            let commitMsgDesc = DescUtils.sequenceDescription(statusList)//sequence commit msg description for the commit
            Swift.print("commitMsgDesc: " + "\(commitMsgDesc)")
            let commitResult = GitModifier.commit(localRepoPath, commitMsgTitle, commitMsgDesc) //commit
            Swift.print("commitResult: " + "\(commitResult)")
            return true//return true to indicate that the commit completed
        }else{
            Swift.print("nothing to add or commit")
            return false //break the flow since there is nothing to commit or process
        }
    }
}
