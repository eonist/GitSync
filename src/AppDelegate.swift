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
        /*
        
        let repoXML = FileParser.xml(repoFilePath.tildePath)
        let repoList = XMLParser.toArray(repoXML)
        Swift.print("repoList.count: " + "\(repoList.count)")
        
        Utils.initCommit(repoList[0], "master")
        */
        
        //Utils.initPush(repoList[0], "master")
        
        
        let str = "testing this stuff.121"
        
        
        let escaped = str.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLPathAllowedCharacterSet())
        Swift.print("escaped: " + "\(escaped)")//escaped: Optional("testing%20this%20stuff.121")
        //(test as NSString).UTF8String
        
        let unEscaped = escaped!.stringByRemovingPercentEncoding
        Swift.print("unEscaped: " + "\(unEscaped)")//unEscaped: Optional("testing this stuff.121")
        
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
}

private class Utils{
    /**
     * Handles the process of making a commit for a single repository
     */
    class func initCommit(repoItem:Dictionary<String,String>,_ branch:String){
        //log "GitSync's handle_commit_interval() a repo with doCommit " & (remote_path of repo_item) & " local path: " & (local_path of repo_item)
        
        let localPath:String = repoItem["local-path"]!
        //Swift.print("localPath: " + "\(localPath)")
        let hasUnMergedpaths = GitAsserter.hasUnMergedPaths(localPath)//Asserts if there are unmerged paths that needs resolvment
        Swift.print("hasUnMergedpaths: " + "\(hasUnMergedpaths)")
        if(hasUnMergedpaths){
            Swift.print("has unmerged paths to resolve")
            let unMergedFiles = GitParser.unMergedFiles(localPath) //Asserts if there are unmerged paths that needs resolvment
            MergeUtils.resolveMergeConflicts(localPath, branch, unMergedFiles)
        }
        let hasCommited = GitSync.doCommit(localPath) //if there were no commits false will be returned
        Swift.print("hasCommited: " + "\(hasCommited)")
    }
    /**
     * Handles the process of making a push for a single repository
     * NOTE: We must always merge the remote branch into the local branch before we push our changes.
     * NOTE: this method performs a "manual pull" on every interval
     * TODO: contemplate implimenting a fetch call after the pull call, to update the status, whats the diff between git fetch and git remote update again?
     */
    class func initPush(repoItem:Dictionary<String,String>,_ branch:String){
        Swift.print("initPush")
        let localPath:String = repoItem["local-path"]!
        let remotePath:String = repoItem["remote-path"]!
        MergeUtils.manualMerge(localPath, remotePath, branch)//commits, merges with promts, (this method also test if a merge is needed or not, and skips it if needed)
        let hasLocalCommits = GitAsserter.hasLocalCommits(localPath, branch) //TODO: maybe use GitAsserter's is_local_branch_ahead instead of this line
        if (hasLocalCommits) { //only push if there are commits to be pushed, hence the has_commited flag, we check if there are commits to be pushed, so we dont uneccacerly push if there are no local commits to be pushed, we may set the commit interval and push interval differently so commits may stack up until its ready to be pushed, read more about this in the projects own FAQ
            let theKeychainItemName = repoItem["keychain-item-name"]!
            //Swift.print("theKeychainItemName: " + "\(theKeychainItemName)")
            let keychainPassword = KeyChainParser.password(theKeychainItemName)
            Swift.print("keychainPassword: " + "\(keychainPassword)")
            let remoteAccountName = theKeychainItemName
            Swift.print("remoteAccountName: " + "\(remoteAccountName)")
            let pushCallBack = GitModifier.push(localPath, remotePath, remoteAccountName, keychainPassword, branch)
            Swift.print("pushCallBack: " + "\(pushCallBack)")
        }
    }
    
}

/*
let appSupportPath = (NSFileManager.defaultManager().URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask).first! as NSURL).path!
Swift.print("appSupportPath: " + "\(appSupportPath)")

let libraryPath = (NSFileManager.defaultManager().URLsForDirectory(.LibraryDirectory, inDomains: .UserDomainMask).first! as NSURL).path!

Swift.print("libraryPath: " + "\(libraryPath)")*/
