import Foundation

class MergeConflictReslover {
    static let shared = MergeConflictReslover()
    static var conflictCount:Int = 0
    static var curConflictIteration:Int = 0
    static var unMergedFiles:[String] = []
    static var curRepoItem:RepoItem?
    /**
     * Promts the user with a list of options to aid in resolving merge conflicts
     * PARAM branch: the branch you tried to merge into
     */
    static func resolveMergeConflicts(_ repoItem:RepoItem, _ unMergedFiles:[String]){
        //log "resolve_merge_conflicts()"
        //log ("MergeUtil's resolve_merge_conflicts()")
        conflictCount = unMergedFiles.count
        self.unMergedFiles = unMergedFiles
        self.repoItem = repoItem
        nextConflict()
        
    }
    /**
     *
     */
    static func nextConflict(){
        let lastSelectedAction:String = options.first! //you may want to make this a "property" to store the last item more permenantly
        Swift.print("localRepoPath: " + "\(repoItem.localPath)")
        Swift.print("branch: " + "\(repoItem.branch)")
        Swift.print("lastSelectedAction: " + "\(lastSelectedAction)")
        Swift.print("unMergedFile: " + "\(unMergedFile)")
        
        
        let issue:String = "Conflict: Resolve merge conflict in"//Local file is older than the remote file
        let file:String = "File: \(unMergedFile)"
        let repo:String = "Repository: \(repoItem.title)"
        
        
        let mergeConflict = MergeConflict(issue:issue,file:file,repo:repo)
        Nav.setView(.dialog(.conflict(mergeConflict)))
        //promt user with list of options, title: Merge conflict in: unmerged_file
        //listWindow.addTarget(self, action: "Complete: ", forControlEvents: .complete)
        
        //            fatalError("mergeConflict resolutin is not implemented yet")//☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️
    }
    
    
    /**
     * Handles the choice made in the merge conflict dialog
     * TODO: test the open file clauses
     */
    private static func handleMergeConflictDialog(_ selected:String, _ unmergedFile:String, _ localRepoPath:String, _ branch:String, _ unmergedFiles:[String]){
        //Swift.print("MergeUtil.handleMergeConflictDialog())
        //last_selected_action = selected
        switch selected{
        case options[0]:/*keep local version*/
            _ = GitModifier.checkOut(localRepoPath, "--ours", unmergedFile)
        case options[1]:/*keep remote version*/
            _ = GitModifier.checkOut(localRepoPath, "--theirs", unmergedFile)
        case options[2]:/*keep mix of both versions*/
            _ = GitModifier.checkOut(localRepoPath, branch, unmergedFile)
        case options[3]:/*open local version*/
            _ = GitModifier.checkOut(localRepoPath, "--ours", unmergedFile)
            FileUtils.openFile(localRepoPath + unmergedFile)
        case options[4]:/*open remote version*/
            _ = GitModifier.checkOut(localRepoPath, "--theirs", unmergedFile)
            FileUtils.openFile(localRepoPath + unmergedFile)
        case options[5]:/*open mix of both versions*/
            _ = GitModifier.checkOut(localRepoPath, branch, unmergedFile)
            FileUtils.openFile(localRepoPath + unmergedFile)
        case options[6]:/*keep all local versions*/
            _ = GitModifier.checkOut(localRepoPath, "--ours", "*")
        case options[7]:/*keep all remote versions*/
            _ = GitModifier.checkOut(localRepoPath, "--theirs", "*")
        case options[8]:/*keep all local and remote versions*/
            _ = GitModifier.checkOut(localRepoPath, branch, "*")
        case options[9]:/*open all local versions*/
            _ = GitModifier.checkOut(localRepoPath, "--ours", "*")
            FileUtils.openFiles([])/*localRepoPath unmergedFiles*/
        case options[10]:/*open all remote versions*/
            _ = GitModifier.checkOut(localRepoPath, "--theirs", "*")
            FileUtils.openFiles([])/*localRepoPath,unmergedFiles*/
        case options[11]:/*open all mixed versions*/
            _ = GitModifier.checkOut(localRepoPath, branch, "*")
            FileUtils.openFiles([])/*localRepoPath,unmergedFiles*/
        default:
            break;
        }
    }
}
