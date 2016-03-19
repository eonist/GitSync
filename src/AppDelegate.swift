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
    }
    /**
     * This method generates a git status list,and asserts if a commit is due, and if so, compiles a commit message and then tries to commit
     * Returns true if a commit was made, false if no commit was made or an error occured
     * NOTE: checks git staus, then adds changes to the index, then compiles a commit message, then commits the changes, and is now ready for a push
     * NOTE: only commits if there is something to commit
     * TODO: add branch parameter to this call
     * NOTE: this a purly local method, does not need to communicate with remote servers etc..
     */
    func doCommit(localRepoPath:String){
        Swift.print("doCommit()")
        let statusList = StatusUtil.generateStatusList(localRepoPath)//get current status
        /*log ("GitSync's do_commit()")
        --log "do_commit"
        
        if (length of status_list > 0) then
        log tab & "there is something to add or commit"
        --log tab & "length of status_list: " & (length of status_list)
        my StatusUtil's process_status_list(local_repo_path, status_list) --process current status by adding files, now the status has changed, some files may have disapared, some files now have status as renamed that prev was set for adding and del
        set commit_msg_title to my CommitUtil's sequence_commit_msg_title(status_list) --sequence commit msg title for the commit
        log tab & "commit_msg_title: " & commit_msg_title
        set commit_msg_desc to my DescUtil's sequence_description(status_list) --sequence commit msg description for the commit
        log tab & "commit_msg_desc: " & commit_msg_desc
        try --try to make a git commit
        set commit_result to GitModifier's commit(local_repo_path, commit_msg_title, commit_msg_desc) --commit
        log tab & "commit_result: " & commit_result
        on error errMsg
        log tab & "----------------ERROR:-----------------" & errMsg
        end try
        return true --return true to indicate that the commit completed
        else
        log tab & "nothing to add or commit"
        return false --break the flow since there is nothing to commit or process
        end if*/
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
