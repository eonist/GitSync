import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    weak var window: NSWindow!
    
    var repoFilePath:String = "~/Desktop/repo.xml"

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        //Swift.print("hello world")
        //let status = GitParser.status("~/Desktop/css","")
        //Swift.print("status: " + "\(status)")
        
        
        //let result = ShellUtils.exc("git status").output
        //Swift.print("result: " + "\(result)")
        
        
        //TODO: 1. Read the repo.xml file and store the xml props in a array dictionary structure
        let repoXML = FileParser.xml(repoFilePath.tildePath)
        let repoList = XMLParser.toArray(repoXML)
        Swift.print("repoList.count: " + "\(repoList.count)")
        prepareToCommit(repoList[0], "master")
    }
    /**
     * Handles the process of making a commit for a single repository
     */
    func prepareToCommit(repoItem:Dictionary<String,String>,_ branch:String){
        //log "GitSync's handle_commit_interval() a repo with doCommit " & (remote_path of repo_item) & " local path: " & (local_path of repo_item)
        
        let localPath:String = repoItem["local-path"]!
        Swift.print("localPath: " + "\(localPath)")
        let remotePath:String = repoItem["remote-path"]!
        Swift.print("remotePath: " + "\(remotePath)")
        let hasUnMergedpaths = GitAsserter.hasUnMergePaths(localPath)//Asserts if there are unmerged paths that needs resolvment
        Swift.print("hasUnMergedpaths: " + "\(hasUnMergedpaths)")
        if(hasUnMergedpaths){
            Swift.print("has unmerged paths to resolve")
            let unMergedFiles = GitParser.unMergedFiles(localPath) //Asserts if there are unmerged paths that needs resolvment
            MergeUtils.resolveMergeConflicts(localPath, branch, unMergedFiles)
        }
        log do_commit(local_path of repo_item) --if there were no commits false will be returned
        --log "has_commited: " & has_commited
    }
    /**
     * This method generates a git status list,and asserts if a commit is due, and if so, compiles a commit message and then tries to commit
     * Returns true if a commit was made, false if no commit was made or an error occured
     * NOTE: checks git staus, then adds changes to the index, then compiles a commit message, then commits the changes, and is now ready for a push
     * NOTE: only commits if there is something to commit
     * TODO: add branch parameter to this call
     * NOTE: this a purly local method, does not need to communicate with remote servers etc..
     */
    func doCommit(localRepoPath:String)->Bool{
        Swift.print("doCommit()")
        let statusList = StatusUtils.generateStatusList(localRepoPath)//get current status
        if (statusList.count > 0) {
            Swift.print("there is something to add or commit")
            StatusUtils.processStatusList(localRepoPath, statusList) //process current status by adding files, now the status has changed, some files may have disapared, some files now have status as renamed that prev was set for adding and del
            let commitMsgTitle = CommitUtils.sequenceCommitMsgTitle(statusList) //sequence commit msg title for the commit
            Swift.print("commitMsgTitle: " + "\(commitMsgTitle)")
            let commitMsgDesc = DescUtils.sequenceDescription(statusList)//sequence commit msg description for the commit
            Swift.print("commitMsgDesc: " + "\(commitMsgDesc)")
            let commitResult = GitModifier.commit(localRepoPath, commitMsgTitle, commitMsgDesc) //commit
            Swift.print("commitResult: " + "\(commitResult)")
            return true//return true to indicate that the commit completed
        }else{
            Swift.print("nothing to add or commit")
            return false //break the flow since there is nothing to commit or process
        }
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
}

/*
let appSupportPath = (NSFileManager.defaultManager().URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask).first! as NSURL).path!
Swift.print("appSupportPath: " + "\(appSupportPath)")

let libraryPath = (NSFileManager.defaultManager().URLsForDirectory(.LibraryDirectory, inDomains: .UserDomainMask).first! as NSURL).path!

Swift.print("libraryPath: " + "\(libraryPath)")*/
