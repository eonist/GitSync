import Foundation
@testable import Utils
/**
 * Utility methods for parsing the repository.xml file
 */
class RepoUtils {
    /**
     * Returns a flat Array of RepoItems derived from a nested xml Structure (also skips folders)
     */
    static var repoListFlattened:[RepoItem] {
        let repoXML:XML = RepoView.node.xml/*📝 - FilePath*/
        let arr:[Any] = XMLParser.arr(repoXML)//convert xml to multidimensional array
        let flatArr:[[String:String]] = arr.recursiveFlatmap()
        //Swift.print("flatArr.count: " + "\(flatArr.count)")
        //flatArr.forEach{Swift.print("$0: " + "\($0)")}
        let repoList:[RepoItem] = Utils.filterFolders(flatArr)        //Swift.print("repoList.count: " + "\(repoList.count)")
        //Swift.print("repoList[0]: " + "\(repoList[0])")
        return repoList//.filter{$0.title == "Research" || $0.title == "Research wiki"}/*👈 filter enables you to test one item at the time, for debugging*/
    }
    /**
     * Returns a flat Array of RepoItems derived from a nested xml Structure
     * NOTE: parent override child for every key in overrideKeys
     * We want parent folders to override all its children.
     * 🏀 TODO: You have to assert the overriding dict that is a folder. try with real data. Then adjust if it doesn't work
     */
    static var repoListFlattenedOverridden:[RepoItem]{
        let repoXML:XML = RepoView.node.xml/*📝 - FilePath*/
        let arr:[Any] = XMLParser.arr(repoXML)//convert xml to multidimensional array
        let overrideKeys:[String] = [RepoItemType.active,RepoItemType.autoSyncInterval,RepoItemType.download,RepoItemType.fileChange,RepoItemType.pullToAutoSync,RepoItemType.upload]/*These are the keys to the values that should be overridden*/
        let flatArr:[[String:String]] = Utils.recursiveFlattened(arr,overrideKeys)
        let repoList:[RepoItem] = Utils.filterFolders(flatArr)//remove folders
        return repoList
    }
    /**
     * Conforms repoItem data and returns a RepoItem that can be used with git
     * TODO: if the interval values is not set, then use default values
     * TODO: test if the full/partly file path still works?
     */
    static func repoItem(_ dict:[String:String]) -> RepoItem{
        /*
        let keychainItemName:String = dict[RepoItemType.keyChainItemName]!
        let interval:String = dict[RepoItemType.interval]!//default is 1min
        var repoItem:RepoItem = RepoItem()
        let localPath:String = dict[RepoItemType.localPath]! //this is the path to the local repository (we need to be in this path to execute git commands on this repo)
        //localPath = ShellUtils.run("echo " + StringModifier.wrapWith(localPath,"'") + " | sed 's/ /\\\\ /g'")//--Shell doesnt handle file paths with space chars very well. So all space chars are replaced with a backslash and space, so that shell can read the paths.
        repoItem.localPath = localPath
        repoItem.interval = interval.int
        repoItem.branch = dict[RepoItemType.branch]!
        repoItem.keyChainItemName = keychainItemName
        repoItem.upload = dict[RepoItemType.upload]!.bool
        repoItem.title = dict[RepoItemType.title]!
        repoItem.download = dict[RepoItemType.download]!.bool
        repoItem.active = dict[RepoItemType.active]!.bool
        let remotePath:String = dict[RepoItemType.remotePath]!
        //remotePath = RegExp.replace(remotePath,"^https://.+$","")//support for partial and full url, strip away the https://, since this will be added later
        //print(remotePath)
        repoItem.remotePath = remotePath
        */
        var repoItem:RepoItem = RepoItem()
        repoItem.active = dict[RepoItemType.active]!.bool
        repoItem.title = dict[RepoItemType.title]!
        return repoItem
    }
    /**
     * Returns an RepoItem for PARAM: xml at PARAM: idx
     * PARAM: idx: matrixIndex
     */
    static func repoItem(_ xml:XML,_ idx:[Int]) -> RepoItem{
        let child:XML = XMLParser.childAt(xml, idx)!
        let dict:[String:String] = child.attribs
        let repoItem = self.repoItem(dict)
        return repoItem
    }
}
private class Utils{
    /**
     * Recursive flatMap with parent overriding abilities
     * NOTE: this also lets parents override the values in some keyes in children
     * INPUT: [[["color": "blue", "value": "003300", "title": "John"], [[["color": "orange", "value": "001122", "title": "Ben"]]]]]
     * OUTPUT: [["color": "blue", "value": "003300", "title": "John"], ["color": "blue", "value": "001122", "title": "Ben"]]
     */
    static func recursiveFlattened<T>(_ arr:[Any], _ overrideables:[String], _ parent:[String:String]? = nil) -> [T]{
        var result:[T] = []
        var parent:[String:String]? = parent
        arr.forEach{
            let itm = $0
            if(itm is AnyArray){/*array*/
                let a:[Any] = itm as! [Any]
                result += recursiveFlattened(a,overrideables,parent)
            }else{/*item*/
                var dict:[String:String] = itm as! [String:String]
                if(parent != nil){
                    
                    overrideables.forEach{
                        if(parent![$0] != nil){
                            dict.updateValue(parent![$0]!,forKey:$0)//creates new key,value pair if non exists
                        }
                    }
                }else{
                    Swift.print("should happen once")
                }
                result.append(dict as! T)
                parent = dict
            }
        }
        return result
    }
    /**
     * Compiles array with tuples and filter out folder related stuff
     */
    static func filterFolders(_ list:[[String:String]])->[RepoItem]{
        let repoList:[RepoItem] = list.filter{
            ($0["hasChildren"] == nil) && ($0["isOpen"] == nil)/*skips folders*/
            }.map{/*create array of tuples*/
                RepoUtils.repoItem($0)
        }
        return repoList
    }
}
