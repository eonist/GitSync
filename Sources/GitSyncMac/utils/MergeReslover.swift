import Foundation
@testable import Utils

class MergeReslover {
    static let shared = MergeReslover()
    var conflictCount:Int = 0
    var index:Int = 0
    var unMergedFiles:[String] = []
    var repoItem:RepoItem?
    /**
     * Promts the user with a list of options to aid in resolving merge conflicts
     * PARAM branch: the branch you tried to merge into
     */
     func resolveConflict(_ repoItem:RepoItem, _ unMergedFiles:[String]){
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
        let lastSelectedAction:String = options.first! //you may want to make this a "property" to store the last item more permenantly
        guard let repoItem = repoItem else{fatalError("error")}
        Swift.print("localRepoPath: " + "\(String(describing: repoItem.localPath))")
        Swift.print("branch: " + "\(String(describing: repoItem.branch))")
        Swift.print("lastSelectedAction: " + "\(lastSelectedAction)")
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
    
     var options:[String] = [
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
                Swift.print("")
            case .remote:
                Swift.print("")
            case .mix:
                Swift.print("")
            }
        }
        let selected = ""
        switch selected{
        case options[0]:/**/
            
        case options[1]:/**/
            
        case options[2]:/**/
            
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
