import Foundation
@testable import Utils
/**
 * Utility methods for merging branches
 */
struct MergeConflict {
    let issue: String, file: String, repo: String
}
extension MergeConflict {
    static let dummyData: MergeConflict = {
        let issue: String = "Conflict: Local file is older than the remote file"
        let file: String = "File: Element.swift"
        let repo: String = "Repository: Element - iOS"
        return MergeConflict(issue: issue, file: file, repo: repo)
    }()
}

class MergeUtils{
    typealias ManualMergeComplete = () -> Void
    /**
     * Manual merge
     * - NOTE: tries to merge a remote branch into a local branch
     * - NOTE: prompts the users if a merge conflicts occure
     * - TODO: we should use two branch params here since its entirly possible to merge from a different remote branch
     */
    static func manualMerge(_ repoItem: RepoItem, _ onManualMergeComplete:@escaping ManualMergeComplete) {
//        Swift.print("🍊 MergeUtils.manualMerge()")
        var hasUnMergedPaths: Bool  {
            return GitAsserter.hasUnMergedPaths(repoItem.localPath)//🌵 Asserts if there are unmerged paths that needs resolvment
        }
        var hasManualPullReturnedError: Bool {
            return GitUtils.manualPull(repoItem.gitRepo)//🌵 Manual pull down files
        }
        if  hasUnMergedPaths || hasManualPullReturnedError {
//            Swift.print("has unmerged paths to resolve")
            let unMergedFiles: [String] = GitParser.unMergedFiles(repoItem.localPath)//🌵 Compile a list of conflicting files somehow
            MergeReslover.shared.resolveConflicts(repoItem, unMergedFiles){
                //_ = GitSync.commit(repoItem.localPath)//🌵 It's best practice to always commit any uncommited files before you attempt to pull, add,commit if any files has an altered status
                onManualMergeComplete()
            }//🌵 Asserts if there are unmerged paths that needs resolvment
        }else {
//            Swift.print("MergeUtils.manualMerge() no resolvment needed")
            onManualMergeComplete()
        }
    }
}
