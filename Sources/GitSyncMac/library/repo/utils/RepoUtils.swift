import Foundation
@testable import Utils
/**
 * Utility methods for parsing the repository.xml file
 */
class RepoUtils{
    /**
     * Returns a flat Array of RepoItems derived from a nested xml Structure (also skips folders)
     */
    static var repoList:[RepoItem]{
        let repoXML:XML
        if(RepoView.node != nil){
            repoXML = RepoView.node!.xml//re-use if it already exists
        }else{
            repoXML = FileParser.xml(RepoView.repoList.tildePath)//or load a fresh copy
        }
        let arr:[Any] = XMLParser.arr(repoXML)//convert xml to multidimensional array
        let flatArr:[[String:String]] = arr.recursiveFlatmap()
        //Swift.print("flatArr.count: " + "\(flatArr.count)")
        //flatArr.forEach{Swift.print("$0: " + "\($0)")}
        let repoList:[RepoItem] = flatArr.filter{
            ($0["hasChildren"] == nil) && ($0["isOpen"] == nil)/*skips folders*/
            }.map{/*create array of tuples*/
                RepoUtils.repoItem($0)
        }
        //Swift.print("repoList.count: " + "\(repoList.count)")
        //Swift.print("repoList[0]: " + "\(repoList[0])")
        return repoList//.filter{$0.title == "Research" || $0.title == "Research wiki"}/*👈 filter enables you to test one item at the time, for debugging*/
    }
    /**
     * Conforms repoItem data and returns a RepoItem that can be used with git
     * TODO: if the interval values is not set, then use default values
     * TODO: test if the full/partly file path still works?
     */
    static func repoItem(_ dict:[String:String]) -> RepoItem{
        let localPath:String = dict["local-path"]! //this is the path to the local repository (we need to be in this path to execute git commands on this repo)
        //localPath = ShellUtils.run("echo " + StringModifier.wrapWith(localPath,"'") + " | sed 's/ /\\\\ /g'")//--Shell doesnt handle file paths with space chars very well. So all space chars are replaced with a backslash and space, so that shell can read the paths.
        let remotePath:String = dict["remote-path"]!
        //remotePath = RegExp.replace(remotePath,"^https://.+$","")//support for partial and full url, strip away the https://, since this will be added later
        //print(remotePath)
        let keychainItemName:String = dict["keychain-item-name"]!
        let interval:String = dict["interval"]!//default is 1min
        var repoItem:RepoItem = RepoItem()
        repoItem.localPath = localPath
        repoItem.interval = interval.int
        repoItem.branch = dict["branch"]!
        repoItem.keyChainItemName = keychainItemName
        repoItem.upload = dict["broadcast"]!.bool
        repoItem.title = dict["title"]!
        repoItem.download = dict["subscribe"]!.bool
        repoItem.active = dict["auto-sync"]!.bool
        repoItem.remotePath = remotePath
        return repoItem
    }
    static func repoItem(_ xml:XML,_ idx:[Int]) -> RepoItem{
        let child:XML = XMLParser.childAt(xml, idx)!
        let dict:[String:String] = child.attribs
        let repoItem = self.repoItem(dict)
        return repoItem
    }
}
