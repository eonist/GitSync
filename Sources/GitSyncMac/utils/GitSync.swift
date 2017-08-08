import Foundation
@testable import Utils

class GitSync{
    typealias PushComplete = (/*_ hasPushed:Bool*/)->Void
    /**
     * Handles the process of making a commit for a single repository
     * PARAM: idx: stores the idx of the repoItem in PARAM repoList which is needed in the onComplete to then start the push on the correct item
     */
    static func initCommit(_ repoItem:RepoItem, commitMessage:CommitMessage? = nil, _ onPushComplete:@escaping PushComplete){
        Swift.print("GitSync.initCommit")
        //bg.async {/*All these git processes needs to happen one after the other*/
            if let unMergedFiles = GitParser.unMergedFiles(repoItem.local).optional {/*🌵Asserts if there are unmerged paths that needs resolvment, aka remote changes that isnt in local*/
                Swift.print("unMergedFiles: " + "\(unMergedFiles)")
                
                
                M.resolveMergeConflicts(repoItem, unMergedFiles)
            }
            let hasCommited = commit(repoItem.local,commitMessage)/*🌵 if there were no commits false will be returned*/
            Swift.print("hasCommited: " + "\(hasCommited)")
//          hasCommited ? initPush(repoItem,onComplete: onPushComplete) : onPushComplete()
            //TODO:⚠️️⚠️️⚠️️⚠️️⚠️️⚠️️⚠️️⚠️️ the next step should be psuh or check if you need to pull down changes and subsequently merge something
            initPush(repoItem,onComplete: onPushComplete)
        //}
    }
    /**
     * Handles the process of making a push for a single repository (When a singular commit has competed this method is called)
     * NOTE: We must always merge the remote branch into the local branch before we push our changes.
     * NOTE: this method performs a "manual pull" on every interval
     * TODO: ⚠️️ Contemplate implimenting a fetch call after the pull call, to update the status, whats the diff between git fetch and git remote update again?
     * IMPORTANT: ⚠️️ this is called on a background thread
     */
    private static func initPush(_ repoItem:RepoItem, onComplete:@escaping PushComplete){
        Swift.print("GitSync.initPush")
        
        MergeUtils.manualMerge(repoItem)//🌵🌵🌵 commits, merges with promts, (this method also test if a merge is needed or not, and skips it if needed)
        let repo:GitRepo = repoItem.gitRepo
        let hasLocalCommits = GitAsserter.hasLocalCommits(repo.localPath, repoItem.branch)/*🌵🌵 TODO: maybe use GitAsserter's is_local_branch_ahead instead of this line*/
        //Swift.print("hasLocalCommits: " + "\(hasLocalCommits)")
        var hasPushed:Bool = false
        if hasLocalCommits { //only push if there are commits to be pushed, hence the has_commited flag, we check if there are commits to be pushed, so we dont uneccacerly push if there are no local commits to be pushed, we may set the commit interval and push interval differently so commits may stack up until its ready to be pushed, read more about this in the projects own FAQ
            guard let keychainPassword:String = KeyChainParser.password("GitSyncApp") else{ fatalError("password not found")}
            //Swift.print("keychainPassword: 🔑" + "\(keychainPassword)" + "repo.keyChainItemName: " + "\(repoItem.keyChainItemName)")
            let key:GitKey = .init(PrefsView.prefs.login, keychainPassword)
            if PrefsView.prefs.login.isEmpty || keychainPassword.isEmpty {fatalError("need login and pass")}
            let pushCallBack = GitModifier.push(repo,key)/*🌵*/
            _ = pushCallBack
            Swift.print("pushCallBack: " + "\(pushCallBack)")
            hasPushed = true
        }
        Swift.print("hasPushed: " + "\(hasPushed)")
//        main.async {/*jump back on the main thread*/
            onComplete()
//        }
    }
    /**
     * This method generates a git status list,and asserts if a commit is due, and if so, compiles a commit message and then tries to commit
     * Returns true if a commit was made, false if no commit was made or an error occured
     * NOTE: checks git staus, then adds changes to the index, then compiles a commit message, then commits the changes, and is now ready for a push
     * NOTE: only commits if there is something to commit
     * TODO: ⚠️️ add branch parameter to this call
     * NOTE: this a purly local method, does not need to communicate with remote servers etc..
     */
    static func commit(_ localRepoPath:String, _ commitMessage:CommitMessage? = nil)->Bool{
        Swift.print("commit()")
        let commitMSG:CommitMessage? = {
            guard let message = commitMessage else {
                return CommitMessageUtils.generateCommitMessage(localRepoPath)
            };return message
        }()
        guard let msg = commitMSG else{
             return false
        }
        let commitResult:String = GitModifier.commit(localRepoPath, CommitMessage(msg.title,msg.description))//🌵 commit
        _ = commitResult
        return true

       
    }
}
