import Foundation
@testable import Utils

class MergeReslover {
    typealias AllComplete = () -> Void
    var allComplete:AllComplete = {fatalError("No handler attached")}
    static let shared = MergeReslover()
    var conflictCount:Int = 0
    var index:Int = 0//curConflictIndex
    var unMergedFiles:[String] = []
    var repoItem:RepoItem?
    /**
     * Promts the user with a list of options to aid in resolving merge conflicts
     * PARAM branch: the branch you tried to merge into
     */
    func resolveConflicts(_ repoItem:RepoItem, _ unMergedFiles:[String], _ allComplete:@escaping AllComplete){
        Swift.print("MergeReslover.resolveConflicts")
        //log "resolve_merge_conflicts()"
        //log ("MergeUtil's resolve_merge_conflicts()")
        self.allComplete = allComplete
        index = 0//reset
        conflictCount = unMergedFiles.count
        self.unMergedFiles = unMergedFiles
        self.repoItem = repoItem
        nextConflict()
    }
    /**
     * Iterate throught the conflicts
     */
     func nextConflict(){
        Swift.print("nextConflict")
        guard index < conflictCount else{//stop iteration if all conflicts are resolved
            Swift.print("allComplete")
            allComplete()
            return
        }
//        let lastSelectedAction:String = options.first! //you may want to make this a "property" to store the last item more permenantly
        guard let repoItem = repoItem else{fatalError("error")}
        Swift.print("localRepoPath: " + "\(String(describing: repoItem.localPath))")
        Swift.print("branch: " + "\(String(describing: repoItem.branch))")
//        Swift.print("lastSelectedAction: " + "\(lastSelectedAction)")
        Swift.print("unMergedFile: " + "\(unMergedFiles[index])")
        
        let issue:String = "Conflict: Resolve merge conflict in"//Local file is older than the remote file
        let file:String = "File: \(unMergedFiles[index])"
        let repo:String = "Repository: \(repoItem.title)"
        
        //Continue here:
            //call processMergeStrategy from MergeResolver
        
        let mergeConflict = MergeConflict(issue:issue,file:file,repo:repo)
        
        
        main.async{
            Nav.setView(.dialog(.conflict(mergeConflict)))//promt user with list of options, title: Merge conflict in: unmerged_file
        }
        
        
        //listWindow.addTarget(self, action: "Complete: ", forControlEvents: .complete)
        
        //fatalError("mergeConflict resolutin is not implemented yet")//☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️☠️
    }
    
    /**
     * Handles the choice made in the merge conflict dialog
     * TODO: test the open file clauses
     */
    func processMergeStrategy(_ option:Option/*, _ unmergedFile:String, _ localRepoPath:String, _ branch:String, _ unmergedFiles:[String]*/){
        Swift.print("MergeUtil.processMergeStrategy()")
        //last_selected_action = selected
        let unmergedFile = unMergedFiles[index]
        Swift.print("unmergedFile: " + "\(unmergedFile)")
        let localRepoPath = repoItem?.localPath ?? {fatalError("error")}()
        Swift.print("localRepoPath: " + "\(localRepoPath)")
        let branch = repoItem?.branch ?? {fatalError("error")}()
        //TODO:⚠️️ merge the two blocks together somehow, they are similar in design
        Swift.print("option: " + "\(option)")
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
            index += 1
            
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
            index = conflictCount
            
        }
         //after each iteration you have to commit, bring that into the fold
        Swift.print("before commit")
        _ = GitSync.commit(localRepoPath)//🌵 It's best practice to always commit any uncommited files before you attempt to pull, add,commit if any files has an altered status
        Swift.print("after commit")
        nextConflict()
        
    }
}

extension MergeReslover{
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

       
