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
        doCommit(repoList[0])
    }
    /**
     * Handles the process of making a commit for a single repository
     */
    func doCommit(repoItem:Dictionary<String,String>){
        //log "GitSync's handle_commit_interval() a repo with doCommit " & (remote_path of repo_item) & " local path: " & (local_path of repo_item)
        
        let localPath:String = repoItem["local-path"]!
        Swift.print("localPath: " + "\(localPath)")
        let remotePath:String = repoItem["remote-path"]!
        Swift.print("remotePath: " + "\(remotePath)")
        let hasUnMergedpaths = GitAsserter .hasUnMergePaths(repoItem["local-path"]!)//Asserts if there are unmerged paths that needs resolvment
        
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
