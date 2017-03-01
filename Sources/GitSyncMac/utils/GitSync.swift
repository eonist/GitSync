import Foundation
@testable import Utils

class GitSync{
    /**
     * Handles the process of making a commit for a single repository
     */
    static func initCommit(_ repoItem:RepoItem, _ onComplete:(_ hasCommited:Bool)->Void){
        //Swift.print("initCommit: title: " + "\(repoItem.title)")
        //log "GitSync's handle_commit_interval() a repo with doCommit " & (remote_path of repo_item) & " local path: " & (local_path of repo_item)
        let hasUnMergedpaths = GitAsserter.hasUnMergedPaths(repoItem.localPath)//🌵Asserts if there are unmerged paths that needs resolvment
        Swift.print("hasUnMergedpaths: " + "\(hasUnMergedpaths)")
        if(hasUnMergedpaths){
            Swift.print("has unmerged paths to resolve")
            let unMergedFiles = GitParser.unMergedFiles(repoItem.localPath)// 🌵 Asserts if there are unmerged paths that needs resolvment
            MergeUtils.resolveMergeConflicts(repoItem.localPath, repoItem.branch, unMergedFiles)
        }
        let hasCommited = commit(repoItem.localPath)//🌵 if there were no commits false will be returned
        //Swift.print("hasCommited: " + "\(hasCommited)")
        onComplete(hasCommited)
    }
    /**
     * Handles the process of making a push for a single repository
     * NOTE: We must always merge the remote branch into the local branch before we push our changes.
     * NOTE: this method performs a "manual pull" on every interval
     * TODO: contemplate implimenting a fetch call after the pull call, to update the status, whats the diff between git fetch and git remote update again?
     */
    static func initPush(_ repoItem:RepoItem,_ onComplete:(_ hasPushed:Bool)->Void){
        Swift.print("initPush")
        var remotePath:String = repoItem.remotePath
        if(remotePath.test("^https://.+$")){remotePath = remotePath.subString(8, remotePath.count)}/*support for partial and full url,strip away the https://, since this will be added later*/
        let repo:GitRepo = (repoItem.localPath, remotePath, repoItem.branch)
        MergeUtils.manualMerge(repo)//commits, merges with promts, (this method also test if a merge is needed or not, and skips it if needed)
        let hasLocalCommits = GitAsserter.hasLocalCommits(repo.localPath, repoItem.branch)/*🌵🌵 TODO: maybe use GitAsserter's is_local_branch_ahead instead of this line*/
        //Swift.print("hasLocalCommits: " + "\(hasLocalCommits)")
        var hasPushed:Bool = false
        if (hasLocalCommits) { //only push if there are commits to be pushed, hence the has_commited flag, we check if there are commits to be pushed, so we dont uneccacerly push if there are no local commits to be pushed, we may set the commit interval and push interval differently so commits may stack up until its ready to be pushed, read more about this in the projects own FAQ
            let keychainPassword = KeyChainParser.password(repoItem.keyChainItemName)
            //Swift.print("keychainPassword: 🔑" + "\(keychainPassword)")
            //Swift.print("repo.keyChainItemName: " + "\(repoItem.keyChainItemName)")
            let key:GitKey = (repoItem.keyChainItemName, keychainPassword)
            let pushCallBack = GitModifier.push(repo,key)/*🌵*/
            _ = pushCallBack
            //Swift.print("pushCallBack: " + "\(pushCallBack)")
            hasPushed = true
        }
        onComplete(hasPushed)
    }
    /**
     * This method generates a git status list,and asserts if a commit is due, and if so, compiles a commit message and then tries to commit
     * Returns true if a commit was made, false if no commit was made or an error occured
     * NOTE: checks git staus, then adds changes to the index, then compiles a commit message, then commits the changes, and is now ready for a push
     * NOTE: only commits if there is something to commit
     * TODO: add branch parameter to this call
     * NOTE: this a purly local method, does not need to communicate with remote servers etc..
     */
    static func commit(_ localRepoPath:String)->Bool{
        Swift.print("commit()")
        
        let statusList = StatusUtils.generateStatusList(localRepoPath)//get current status
        Swift.print("statusList.count: " + "\(statusList.count)")
        
        if (statusList.count > 0) {
            Swift.print("doCommit().there is something to add or commit")
            StatusUtils.processStatusList(localRepoPath, statusList) //process current status by adding files, now the status has changed, some files may have disapared, some files now have status as renamed that prev was set for adding and del
            let title = CommitUtils.sequenceCommitMsgTitle(statusList) //sequence commit msg title for the commit
            Swift.print("commitMsgTitle: " + "\(title)")
            let desc = DescUtils.sequenceDescription(statusList)//sequence commit msg description for the commit
            Swift.print("commitMsgDesc: >" + "\(desc)" + "<")
            let commitResult = GitModifier.commit(localRepoPath, (title,desc)) //commit
            Swift.print("commitResult: " + "\(commitResult)")
            return true//return true to indicate that the commit completed
        }else{
            Swift.print("nothing to add or commit")
            return false //break the flow since there is nothing to commit or process
        }
    }
}
