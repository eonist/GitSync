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
    
    /**
     * Manual merge
     * NOTE: tries to merge a remote branch into a local branch
     * NOTE: prompts the users if a merge conflicts occure
     * TODO: we should use two branch params here since its entirly possible to merge from a different remote branch
     */
    static func manualMerge(_ repoItem:RepoItem){
        Swift.print("🍊 MergeUtils.manualMerge()")
        if GitAsserter.hasUnMergedPaths(repoItem.localPath) { //Asserts if there are unmerged paths that needs resolvment
            //Swift.print("has unmerged paths to resolve")
            let unMergedFiles:[String] = GitParser.unMergedFiles(repoItem.localPath)//🌵 Compile a list of conflicting files somehow
            MergeReslover.shared.resolveConflicts(repoItem, unMergedFiles){
                _ = GitSync.commit(repoItem.localPath)//🌵 It's best practice to always commit any uncommited files before you attempt to pull.
            }//🌵 Asserts if there are unmerged paths that needs resolvment
        }
    
        let hasManualPullReturnedError:Bool = GitUtils.manualPull(repoItem.gitRepo)//🌵 Manual clone down files
        if hasManualPullReturnedError {
            //make a list of unmerged files
            let unMergedFiles:[String] = GitParser.unMergedFiles(repoItem.localPath)//🌵 Compile a list of conflicting files somehow
            MergeReslover.shared.resolveConflicts(repoItem, unMergedFiles){
                _ = GitSync.commit(repoItem.localPath)//🌵 add,commit if any files has an altered status
            }//🌵 Asserts if there are unmerged paths that needs resolvment
            
        }
    }
    
}
