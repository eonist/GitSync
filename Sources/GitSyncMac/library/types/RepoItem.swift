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
extension RepoItem {
  static var names = (
      localPath:"localPath",
      interval:"interval",
      branch:"branch",
      keyChainItemName:"keyChainItemName",
      upload:"upload",
      title:"title",
      download:"download",
      active:"active",
      remotePath:"remotePath",
      autoSyncInterval:"autoSyncInterval",
      autoCommitMessage:"autoCommitMessage",
      fileChange:"fileChange",
      pullToAutoSync:"pullToAutoSync"
  )
}