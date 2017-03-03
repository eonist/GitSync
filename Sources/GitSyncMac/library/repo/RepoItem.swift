import Foundation

struct RepoItem {
    var localPath:String = ""
    var interval:Int = 0
    var branch:String = ""
    var keyChainItemName:String = ""
    var upload:Bool = false
    var title:String = ""
    var download:Bool = false
    var active:Bool = false
    var remotePath:String = ""
    var autoSyncInterval:Bool = false
    var autoCommitMessage:Bool = false
    var fileChange:Bool = false
    var pullToAutoSync:Bool = false
}
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
}
