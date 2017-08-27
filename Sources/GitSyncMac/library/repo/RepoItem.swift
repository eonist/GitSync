import Foundation

/**
 * TODO: Could this be a struct?
 */
struct RepoItem {
    var local:String = ""/*Local path*/
    var branch:String = ""/*Repo branch, Master is default*/
    var title:String = ""/*The title displayed in the app*/
    var active:Bool = false/*Active means that auto and pull will sync the repo*/
    var remote:String = ""/*Remote path to repository*/
    var message:Bool = false/*Auto-created commit message*///TODO: ⚠️️ rename
    var auto:Bool = false/*Automatically syncs on an intervall*///TODO: ⚠️️ rename to interval?
    var template:String = ""
    //var interval:Int = 0
    //var keyChainItemName:String = ""
    //var upload:Bool = false
    //var download:Bool = false
    //var autoSyncInterval:Bool = false
    //var fileChange:Bool = false
    init(local:String,branch:String,title:String,remote:String = ""){
        self.local = local
        self.branch = branch
        self.title = title
        self.remote = remote
    }
    init(){}//don't delete this, you should probably delete it
}

