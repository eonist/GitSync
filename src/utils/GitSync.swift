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
            Swift.print("doCommit().there is something to add or commit")
            StatusUtils.processStatusList(localRepoPath, statusList) //process current status by adding files, now the status has changed, some files may have disapared, some files now have status as renamed that prev was set for adding and del
            let commitMsgTitle = CommitUtils.sequenceCommitMsgTitle(statusList) //sequence commit msg title for the commit
            Swift.print("commitMsgTitle: " + "\(commitMsgTitle)")
            let commitMsgDesc = DescUtils.sequenceDescription(statusList)//sequence commit msg description for the commit
            Swift.print("commitMsgDesc: >" + "\(commitMsgDesc)" + "<")
            let commitResult = GitModifier.commit(localRepoPath, commitMsgTitle, commitMsgDesc) //commit
            Swift.print("commitResult: " + "\(commitResult)")
            return true//return true to indicate that the commit completed
        }else{
            Swift.print("nothing to add or commit")
            return false //break the flow since there is nothing to commit or process
        }
    }
    /**
     * Handles the process of making a commit for a single repository
     */
    class func initCommit(repoItem:Dictionary<String,String>,_ branch:String){
        //log "GitSync's handle_commit_interval() a repo with doCommit " & (remote_path of repo_item) & " local path: " & (local_path of repo_item)
        let localPath:String = repoItem["local-path"]!
        //Swift.print("localPath: " + "\(localPath)")
        let hasUnMergedpaths = GitAsserter.hasUnMergedPaths(localPath)//Asserts if there are unmerged paths that needs resolvment
        Swift.print("hasUnMergedpaths: " + "\(hasUnMergedpaths)")
        if(hasUnMergedpaths){
            Swift.print("has unmerged paths to resolve")
            let unMergedFiles = GitParser.unMergedFiles(localPath) //Asserts if there are unmerged paths that needs resolvment
            MergeUtils.resolveMergeConflicts(localPath, branch, unMergedFiles)
        }
        let hasCommited = GitSync.doCommit(localPath) //if there were no commits false will be returned
        Swift.print("hasCommited: " + "\(hasCommited)")
    }
    /**
     * Handles the process of making a push for a single repository
     * NOTE: We must always merge the remote branch into the local branch before we push our changes.
     * NOTE: this method performs a "manual pull" on every interval
     * TODO: contemplate implimenting a fetch call after the pull call, to update the status, whats the diff between git fetch and git remote update again?
     */
    class func initPush(repoItem:Dictionary<String,String>,_ branch:String){
        Swift.print("initPush")
        let localPath:String = repoItem["local-path"]!
        var remotePath:String = repoItem["remote-path"]!
        
        if(remotePath.test("^https://.+$")){remotePath = remotePath.subString(8, remotePath.count)}/*support for partial and full url,strip away the https://, since this will be added later*/
        
        MergeUtils.manualMerge(localPath, remotePath, branch)//commits, merges with promts, (this method also test if a merge is needed or not, and skips it if needed)
        let hasLocalCommits = GitAsserter.hasLocalCommits(localPath, branch) //TODO: maybe use GitAsserter's is_local_branch_ahead instead of this line
        Swift.print("hasLocalCommits: " + "\(hasLocalCommits)")
        if (hasLocalCommits) { //only push if there are commits to be pushed, hence the has_commited flag, we check if there are commits to be pushed, so we dont uneccacerly push if there are no local commits to be pushed, we may set the commit interval and push interval differently so commits may stack up until its ready to be pushed, read more about this in the projects own FAQ
            let theKeychainItemName = repoItem["keychain-item-name"]!
            //Swift.print("theKeychainItemName: " + "\(theKeychainItemName)")
            let keychainPassword = KeyChainParser.password(theKeychainItemName)
            Swift.print("keychainPassword: " + "\(keychainPassword)")
            let remoteAccountName = theKeychainItemName
            Swift.print("remoteAccountName: " + "\(remoteAccountName)")
            let pushCallBack = GitModifier.push(localPath, remotePath, remoteAccountName, keychainPassword, branch)
            Swift.print("pushCallBack: " + "\(pushCallBack)")
        }
    }
}
