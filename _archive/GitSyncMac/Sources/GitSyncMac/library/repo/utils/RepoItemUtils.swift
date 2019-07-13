import Foundation
@testable import Utils
@testable import Element
/**
 * Utility methods for parsing the repository.xml file
 */
class RepoUtils {
    /**
     * Returns a flat Array of RepoItems derived from a nested xml Structure (also skips folders)
     * - Note: parent override child for every key in overrideKeys
     * - Note: We want parent folders to override all its children.
     * - Note: ⚠️️ You need to check if the local path is still avilable. FileASserter.exists, or else you might get strange bugs using the Git lib, and prompt the user to correct the path
     */
    static var repoListFlattenedOverridden: [RepoItem] {
//        Swift.print("repoListFlattenedOverridden")
        let repoXML: XML = RepoView.treeDP.tree.xml /*📝 - FilePath*/
        let arr: [Any] = XMLParser.arr(repoXML)//convert xml to multidimensional array
//        Swift.print("arr: " + "\(arr)")
        let overrideKeys: [String] = [RepoItem.Key.active,/*RepoType.autoSyncInterval,RepoType.download,RepoType.fileChange,*/RepoItem.Key.auto/*,RepoType.upload*/]/*These are the keys to the values that should be overridden*/
        let overriders: [String] = [RepoFolderType.isOpen.rawValue,RepoFolderType.hasChildren.rawValue]
        let flatArr: [[String: String]] = Utils.recursiveFlattened(arr,overrideKeys,overriders)
        let repoListSansFolders: [RepoItem] = Utils.sansFolders(list:flatArr, mustNotContain:overriders)//remove folders
        let activeRepoList = repoListSansFolders.filter { $0.active } /*filter out inActive*/
//        activeRepoList.forEach{
//            Swift.print("$0.title: " + "\($0.title)")
//        }
        return activeRepoList
    }
    /**
     * Conforms repoItem data and returns a RepoItem that can be used with git
     * - Fixme: ⚠️️ if the interval values is not set, then use default values
     * - Fixme: ⚠️️ test if the full/partly file path still works?
     */
    static func repoItem(dict: [String: String]) -> RepoItem {
        //Swift.print("dict: " + "\(dict)")
        var repoItem: RepoItem = RepoItem()
        let localPath: String = dict[RepoItem.Key.local]! //this is the path to the local repository (we need to be in this path to execute git commands on this repo)
        //localPath = ShellUtils.run("echo " + StringModifier.wrapWith(localPath,"'") + " | sed 's/ /\\\\ /g'")//--Shell doesnt handle file paths with space chars very well. So all space chars are replaced with a backslash and space, so that shell can read the paths.
        repoItem.local = localPath
        repoItem.branch = dict[RepoItem.Key.branch]!
        repoItem.title = dict[RepoItem.Key.title]!
        repoItem.auto = dict[RepoItem.Key.auto]!.bool
        repoItem.message = dict[RepoItem.Key.message]!.bool
        repoItem.template = dict[RepoItem.Key.template] ?? ""
        repoItem.notification = dict[RepoItem.Key.notification]?.bool ?? false
        //Swift.print("dict[RepoType.active.rawValue]!: " + "\(dict[RepoType.active.rawValue]!)")
        repoItem.active = dict[RepoItem.Key.active]!.bool
        let remotePath: String = dict[RepoItem.Key.remote]!
        //remotePath = RegExp.replace(remotePath,"^https://.+$","")//support for partial and full url, strip away the https://, since this will be added later
        //print(remotePath)
        repoItem.remote = remotePath
        return repoItem
    }
    /**
     * Returns an RepoItem for PARAM: xml at PARAM: idx
     * - Parameter: idx: matrixIndex
     * - Fixme: ⚠️️ Should return optional
     */
    static func repoItem(xml:XML,idx:[Int]) -> RepoItem{
        if let child: XML = XMLParser.childAt(xml, idx){
            let dict: [String: String] = child.attribs
            let repoItem = self.repoItem(dict: dict)
            return repoItem
        }; fatalError("no child at idx: \(idx)")
    }
}
private class Utils{
    /**
     * Recursive flatMap with parent overriding abilities
     * - Note: this also lets parents override the values in some keys in children
     * - INPUT: [[["color": "blue", "value": "003300", "title": "John"], [[["color": "orange", "value": "001122", "title": "Ben"]]]]]
     * - OUTPUT: [["color": "blue", "value": "003300", "title": "John"], ["color": "blue", "value": "001122", "title": "Ben"]]
     * - Parameter: overriders: only let items with either of these be able to override (aka folders)
     * - Parameter: overrideKeys: override these key value pairs. If non exist then make new
     * - Fixme: ⚠️️ use throws to give better error description?
     */
    static func recursiveFlattened<T>(_ arr: [Any], _ overrideKeys: [String], _ overriders: [String], _ parent: [String:String]? = nil) -> [T] {
        var result: [T] = []
        var parent: [String:String]? = parent
        arr.forEach{
            if $0 is AnyArray {/*array*/
                let a: [Any] = $0 as! [Any]
                result += recursiveFlattened(a,overrideKeys,overriders,parent)
            }else{/*item*/
                guard var dict: [String:String] = $0 as? [String:String] else {fatalError("err")}
                if let parent = parent {
                    overrideKeys.forEach{
                        if let value = parent[$0] {
                            let val: Bool = String(value).bool
                            if !val {/*only disable overrides*/
                                dict.updateValue(value,forKey:$0)//creates new key,value pair if non exists
                            }
                        }
                    }
                }
                if let dict = dict as? T {result.append(dict)}
                if dict.contains(overriders) {/*folders are the only things that can override*/
                    parent = dict
                }
            }
        }
        return result
    }
    /**
     * Compiles array with tuples and filter out folder related stuff
     */
    static func sansFolders(list: [[String: String]],  mustNotContain: [String]) -> [RepoItem] {
        let repoList: [RepoItem] = list.filter{
            !$0.contains(mustNotContain) && $0.hasKey(RepoItem.Key.active) && $0[RepoItem.Key.active]!.bool/*skips folders, and active must be true*/
            }.map{/*create array of tuples*/
//                Swift.print("$0: " + "\($0)")
                return RepoUtils.repoItem(dict: $0)
        }
        return repoList
    }
}


/**
 * Returns a flat Array of RepoItems derived from a nested xml Structure (also skips folders)
 * TODO: Redesign the flattening, utilize the tree
 */
/*

 DEPREACATE this, we use repoListFlattenedOverridden now

 static var repoListFlattened:[RepoItem] {
 let repoXML:XML = RepoView.treeDP.tree.xml/*📝 - FilePath*/
 let arr:[Any] = XMLParser.arr(repoXML)//convert xml to multidimensional array
 let flatArr:[[String:String]] = arr.recursiveFlatmap()
 //flatArr.forEach{Swift.print("$0: " + "\($0)")}
 let repoList:[RepoItem] = Utils.filterFolders(flatArr,[RepoFolderType.isOpen.rawValue,RepoFolderType.hasChildren.rawValue])//Swift.print("repoList.count: " + "\(repoList.count)")

 let activeRepoList = repoList.filter{$0.active}/*filter out inActive*/
 activeRepoList.forEach{Swift.print("$0.title: " + "\($0.title)")}
 return activeRepoList
 }
 */
/**
 * Returns dupe free flattened repo list
 */
/*

 //TODO: ⚠️️ possibly remove this, its not used, removing dups is cool but we sort of need to sync all repos

 private static var repoListFlattenedDupeFree:[RepoItem]{
 let repoList:[RepoItem] = RepoUtils.repoListFlattened//.filter{$0.title == "GitSync"}//👈 filter enables you to test one item at the time
 return repoList.removeDups({$0.remote == $1.remote && $0.branch == $1.branch})/*remove dups that have the same remote and branch. */
 //Swift.print("After removal of dupes - repoList: " + "\(repoList.count)")
 }*/
