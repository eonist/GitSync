import Foundation
@testable import Utils
/**
 * Utility methods for parsing the repository.xml file
 */
class RepoUtils {
    /**
     * Returns a flat Array of RepoItems derived from a nested xml Structure (also skips folders)
     * TODO: Redesign the flattening, utilize the tree
     */
    static var repoListFlattened:[RepoItem] {
        let repoXML:XML = RepoView.treeDP.xml/*📝 - FilePath*/
        let arr:[Any] = XMLParser.arr(repoXML)//convert xml to multidimensional array
        let flatArr:[[String:String]] = arr.recursiveFlatmap()
        //Swift.print("flatArr.count: " + "\(flatArr.count)")
        //flatArr.forEach{Swift.print("$0: " + "\($0)")}
        let repoList:[RepoItem] = Utils.filterFolders(flatArr,[RepoFolderType.isOpen,RepoFolderType.hasChildren])        //Swift.print("repoList.count: " + "\(repoList.count)")
        return repoList//.filter{$0.title == "Research" || $0.title == "Research wiki"}/*👈 filter enables you to test one item at the time, for debugging*/
    }
    /**
     * Returns dupe free flattened repo list
     */
    static var repoListFlattenedDupeFree:[RepoItem]{
        let repoList:[RepoItem] = RepoUtils.repoListFlattened//.filter{$0.title == "GitSync"}//👈 filter enables you to test one item at the time
        return repoList.removeDups({$0.remotePath == $1.remotePath && $0.branch == $1.branch})/*remove dups that have the same remote and branch. */
        //Swift.print("After removal of dupes - repoList: " + "\(repoList.count)")
    }
    /**
     * Returns a flat Array of RepoItems derived from a nested xml Structure
     * NOTE: parent override child for every key in overrideKeys
     * We want parent folders to override all its children.
     */
    static var repoListFlattenedOverridden:[RepoItem]{
        
        //Continue here: 🏀
            //figure out how to flatten the new xml
        
        let repoXML:XML = RepoView.treeDP.xml/*📝 - FilePath*/
        Swift.print("repoXML.xmlString: " + "\(repoXML.xmlString)")
        let arr:[Any] = XMLParser.arr(repoXML)//convert xml to multidimensional array
        let overrideKeys:[String] = [RepoItemType.active,RepoItemType.autoSyncInterval,RepoItemType.download,RepoItemType.fileChange,RepoItemType.pullToAutoSync,RepoItemType.upload]/*These are the keys to the values that should be overridden*/
        let overriders:[String] = [RepoFolderType.isOpen,RepoFolderType.hasChildren]
        let flatArr:[[String:String]] = Utils.recursiveFlattened(arr,overrideKeys,overriders)
        let repoList:[RepoItem] = Utils.filterFolders(flatArr,overriders)//remove folders
        return repoList
    }
    /**
     * Conforms repoItem data and returns a RepoItem that can be used with git
     * TODO: if the interval values is not set, then use default values
     * TODO: test if the full/partly file path still works?
     */
    static func repoItem(_ dict:[String:String]) -> RepoItem{
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
     * PARAM: overriders: only let items with either of these be able to override (aka folders)
     * PARAM: overrideKeys: override these key value pairs. If non exist then make new
     */
    static func recursiveFlattened<T>(_ arr:[Any], _ overrideKeys:[String], _ overriders:[String],_ parent:[String:String]? = nil) -> [T]{
        var result:[T] = []
        var parent:[String:String]? = parent
        arr.forEach{
            if($0 is AnyArray){/*array*/
                let a:[Any] = $0 as! [Any]
                result += recursiveFlattened(a,overrideKeys,overriders,parent)
            }else{/*item*/
                var dict:[String:String] = $0 as! [String:String]
                if(parent != nil){
                    overrideKeys.forEach{
                        if(parent![$0] != nil){
                            let val:Bool = String(parent![$0]!).bool
                            if(!val){//only disable overrides
                                dict.updateValue(parent![$0]!,forKey:$0)//creates new key,value pair if non exists
                            }
                        }
                    }
                }
                result.append(dict as! T)
                if(dict.contains(overriders)){/*folders are the only things that can override*/
                    parent = dict
                }
            }
        }
        return result
    }
    /**
     * Compiles array with tuples and filter out folder related stuff
     */
    static func filterFolders(_ list:[[String:String]], _ mustNotContain:[String])->[RepoItem]{
        let repoList:[RepoItem] = list.filter{
            (!$0.contains(mustNotContain) && $0.hasKey(RepoItemType.active) && $0[RepoItemType.active]!.bool)/*skips folders, and active must be true*/
            }.map{/*create array of tuples*/
                RepoUtils.repoItem($0)
        }
        return repoList
    }
}
