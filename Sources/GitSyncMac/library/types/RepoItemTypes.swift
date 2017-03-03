import Foundation

typealias RepoItem = (localPath:String,interval:Int,branch:String,keyChainItemName:String,upload:Bool,title:String,download:Bool,active:Bool,remotePath:String,autoSyncInterval:Bool,autoCommitMessage:Bool,fileChange:Bool,pullToAutoSync:Bool)
static var emptyRepoItem:RepoItem = (localPath:"",interval:0,branch:"",keyChainItemName:"",broadcast:false,title:"",subscribe:false,autoSync:false,remotePath:"",autoSyncInterval:)
