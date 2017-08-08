import Foundation
@testable import Utils

class MergeReslover {
    typealias AllComplete = () -> Void
    static let shared = MergeReslover()
    var conflictCount:Int = 0
    var index:Int = 0//curConflictIndex
    var unMergedFiles:[String] = []
    var repoItem:RepoItem?
    /**
     * Promts the user with a list of options to aid in resolving merge conflicts
     * PARAM branch: the branch you tried to merge into
     */
    func resolveConflicts(_ repoItem:RepoItem, _ unMergedFiles:[String], _ onComplete:AllComplete){
        //log "resolve_merge_conflicts()"
        //log ("MergeUtil's resolve_merge_conflicts()")
        conflictCount = unMergedFiles.count
        self.unMergedFiles = unMergedFiles
        self.repoItem = repoItem
        nextConflict()
    }
    /**
     * Iterate throught the conflicts
     */
     func nextConflict(){
        guard index < conflictCount else{return}//stop iteration if all conflicts are resolved
//        let lastSelectedAction:String = options.first! //you may want to make this a "property" to store the last item more permenantly
        guard let repoItem = repoItem else{fatalError("error")}
        Swift.print("localRepoPath: " + "\(String(describing: repoItem.localPath))")
        Swift.print("branch: " + "\(String(describing: repoItem.branch))")
//        Swift.print("lastSelectedAction: " + "\(lastSelectedAction)")
        Swift.print("unMergedFile: " + "\(unMergedFiles[index])")
        
        let issue:String = "Conflict: Resolve merge conflict in"//Local file is older than the remote file
        let file:String = "File: \(unMergedFiles[index])"
        let repo:String = "Repository: \(repoItem.title)"
        
        
        let mergeConflict = MergeConflict(issue:issue,file:file,repo:repo)
        
        Nav.setView(.dialog(.conflict(mergeConflict)))//promt user with list of options, title: Merge conflict in: unmerged_file
        index += 1
        
        //listWindow.addTarget(self, action: "Complete: ", forControlEvents: .complete)
        
        //fatalError("mergeConflict resolutin is not implemented yet")//☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️
    }
    enum Option{
        enum All{
            case local,remote,mix
        }
        enum Singular{
            case local,remote,mix
        }
        case all(All)
        case singular(Singular)
    }
    /**
     * Handles the choice made in the merge conflict dialog
     * TODO: test the open file clauses
     */
    func handleMergeConflictDialog(_ option:Option, _ unmergedFile:String, _ localRepoPath:String, _ branch:String, _ unmergedFiles:[String]){
        //Swift.print("MergeUtil.handleMergeConflictDialog())
        //last_selected_action = selected
        switch option {
        case Option.singular(let singularOption):
            switch singularOption {
            case .local:
                Swift.print("keep local version")
                _ = GitModifier.checkOut(localRepoPath, "--ours", unmergedFile)/*keep local version*/
            case .remote:
                Swift.print("keep remote version")
                _ = GitModifier.checkOut(localRepoPath, "--theirs", unmergedFile)/*keep remote version*/
            case .mix:
                Swift.print("keep mix of both versions")
                _ = GitModifier.checkOut(localRepoPath, branch, unmergedFile)
            }
        case Option.all(let allOption):
            switch allOption {
            case .local:
                Swift.print("keep all local versions")
                _ = GitModifier.checkOut(localRepoPath, "--ours", "*")/*keep all local versions*/
            case .remote:
                Swift.print("keep all remote versions")
                _ = GitModifier.checkOut(localRepoPath, "--theirs", "*")
            case .mix:
                Swift.print("keep all local and remote versions")
                _ = GitModifier.checkOut(localRepoPath, branch, "*")
            }
        }
        
        
        /*open local version*/
        //_ = GitModifier.checkOut(localRepoPath, "--ours", unmergedFile)
        //FileUtils.openFile(localRepoPath + unmergedFile)
        
        /*open remote version*/
//        _ = GitModifier.checkOut(localRepoPath, "--theirs", unmergedFile)
//        FileUtils.openFile(localRepoPath + unmergedFile)
        
        /*open mix of both versions*/
//        _ = GitModifier.checkOut(localRepoPath, branch, unmergedFile)
//        FileUtils.openFile(localRepoPath + unmergedFile)
        
        /*open all local versions*/
//        _ = GitModifier.checkOut(localRepoPath, "--ours", "*")
//        FileUtils.openFiles([])/*localRepoPath unmergedFiles*/
        
        /*open all remote versions*/
//        _ = GitModifier.checkOut(localRepoPath, "--theirs", "*")
//        FileUtils.openFiles([])/*localRepoPath,unmergedFiles*/

        /*open all mixed versions*/
//        _ = GitModifier.checkOut(localRepoPath, branch, "*")
//        FileUtils.openFiles([])/*localRepoPath,unmergedFiles*/
        
        
    }
}
