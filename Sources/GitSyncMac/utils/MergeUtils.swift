import Foundation
@testable import Utils
/**
 * Utility methods for merging branches
 */
struct MergeConflict{
    let issue:String,file:String,repo:String
    static let dummyData:MergeConflict = {
        let issue:String = "Conflict: Local file is older than the remote file"
        let file:String = "File: Element.swift"
        let repo:String = "Repository: Element - iOS"
        return MergeConflict(issue: issue, file: file, repo: repo)
    }()
}

class MergeUtils{
    static var options:[String] = [
        "keep local version",
        "keep remote version",
        "keep mix of both versions",
        "open local version",
        "open remote version",
        "open mix of both versions",
        "keep all local versions",
        "keep all remote versions",
        "keep all local and remote versions",
        "open all local versions",
        "open all remote versions",
        "open all mixed versions"
    ]
    /**
     * Manual merge
     * NOTE: tries to merge a remote branch into a local branch
     * NOTE: prompts the users if a merge conflicts occure
     * TODO: we should use two branch params here since its entirly possible to merge from a different remote branch
     */
    static func manualMerge(_ repoItem:RepoItem){
        Swift.print("🍊 MergeUtils.manualMerge()")
        if (GitAsserter.hasUnMergedPaths(repoItem.localPath)) { //Asserts if there are unmerged paths that needs resolvment
            //Swift.print("has unmerged paths to resolve")
            MergeReslover.shared.resolveConflicts(repoItem, GitParser.unMergedFiles(repoItem.localPath))//🌵 Asserts if there are unmerged paths that needs resolvment
        }
        _ = GitSync.commit(repoItem.localPath)//🌵 It's best practice to always commit any uncommited files before you attempt to pull.

        let hasManualPullReturnedError:Bool = GitUtils.manualPull(repoItem.gitRepo)//🌵 Manual clone down files
        if(hasManualPullReturnedError){
            //make a list of unmerged files
            let unMergedFiles:[String] = GitParser.unMergedFiles(repoItem.localPath)//🌵 Compile a list of conflicting files somehow
            MergeReslover.shared.resolveConflicts(repoItem, unMergedFiles)//🌵 Asserts if there are unmerged paths that needs resolvment
            _ = GitSync.commit(repoItem.localPath)//🌵 add,commit if any files has an altered status
        }else{
            //Swift.print("MergeUtils.manualMerge() Success no resolvment needed")
        }
    }
    
}
