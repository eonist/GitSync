import Foundation

struct RepoItem {
    var localPath:String = ""
    var branch:String = ""
    var title:String = ""
    var active:Bool = false
    var remotePath:String = ""
    var autoCommitMessage:Bool = false
    var pullToAutoSync:Bool = false
    //var interval:Int = 0
    //var keyChainItemName:String = ""
    //var upload:Bool = false
    //var download:Bool = false
    //var autoSyncInterval:Bool = false
    //var fileChange:Bool = false
    
}
enum RepoType:String{
    case name = "name"
    case local = "local"
    case remote = "remote"
    case branch = "branch"
    case auto = "auto"
    case message = "message"
    case active = "active"
}
class RepoFolderType{
    static var isOpen:String = "isOpen"
    static var hasChildren:String = "hasChildren"
}

/*
 class RepoItemType {
 static var localPath:String = "localPath"
 static var interval:String = "interval"
 static var branch:String = "branch"
 static var keyChainItemName:String = "keyChainItemName"
 static var upload:String = "upload"
 static var title:String = "title"
 static var download:String = "download"
 static var active:String = "active"
 static var remotePath:String = "remotePath"
 static var autoSyncInterval:String = "autoSyncInterval"
 static var autoCommitMessage:String = "autoCommitMessage"
 static var fileChange:String = "fileChange"
 static var pullToAutoSync:String = "pullToAutoSync"
 }*/
