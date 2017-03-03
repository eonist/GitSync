import Foundation

typealias RepoItem = (
    localPath:String,
    interval:Int,
    branch:String,
    keyChainItemName:String,
    upload:Bool,
    title:String,
    download:Bool,
    active:Bool,
    remotePath:String,
    autoSyncInterval:Bool,
    autoCommitMessage:Bool,
    fileChange:Bool,
    pullToAutoSync:Bool
)
class RepoItemTypes{
    static var emptyRepoItem:' = (
        localPath:"",
        interval:0,
        branch:"",
        keyChainItemName:"",
        upload:false,
        title:"",
        download:false,
        active:false,
        remotePath:"",
        autoSyncInterval:false,
        autoCommitMessage:false,
        fillChange:false,
        pullToAutoSync:false
    )
}
