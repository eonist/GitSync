import Foundation
@testable import Utils
@testable import Element

extension RepoDetailView{
    /**
     * Populates the UI elements with data from the dp item
     * NOTE: Uses the Unfold lib to set data
     */
    public func setRepoData(){
        let idx3d = RepoView.selectedListItemIndex
        let repoItem = RepoItem.repoItem(treeDP: RepoView.treeDP, idx3d: idx3d)
        
        Swift.print("setRepoData(repoItem)")
        /*TextInput*/
        self.apply([Key.title],repoItem.title)
        self.apply([Key.local],repoItem.local)
        self.apply([Key.remote],repoItem.remote)
        self.apply([Key.branch],repoItem.branch)
        self.apply([Key.template],repoItem.template)
        
        /*CheckButtons*/
        let closure = { (path:[String],key:String) in
            if let ui:CheckBoxButton = try? UnfoldParser.unfoldable(parent:self, path:path) {
//                Swift.print("ui: " + "\(ui)")
                guard let checkedState:Bool = repoItem[key] else {fatalError("err")}//Utils.checkedState(repoItem,idx3d,key)
//                Swift.print("checkedState: " + "\(checkedState)")
                ui.value = checkedState//.rawValue //we use string not enum state
            }
        }
        closure(["autoGroup",Key.auto],Key.auto)
        closure(["messageGroup",Key.message],Key.message)
        closure(["activeGroup",Key.active],Key.active)
        closure(["notificationGroup",Key.notification],Key.notification)
    }
    /**
     * New, this is used when unfolding RepoDetailViews that are folder types
     */
    func folderJson(fileURL:String,path:String) -> [[String:Any]]{
        guard let jsonDict:[String: Any] = JSONParser.dict(fileURL.content?.json) else{fatalError("fileURL: is incorrect: \(fileURL)")}
        guard let jsonDictItem:Any = jsonDict[path] else{fatalError("path is incorrect: \(path)")}
        guard let jsonArr:[[String:Any]] = JSONParser.dictArr(jsonDictItem) else{fatalError("jsonDictItem: is incorrect")}
        let matchs = ["title","activeGroup","autoGroup","notificationGroup","messageGroup"]
        let filteredJsonArr = jsonArr.filter{
            guard let id:String = $0["id"] as? String else {fatalError("err")}
//            Swift.print("id: " + "\(id)")
            let match:Bool = ArrayAsserter.has(matchs, id)
//            Swift.print("match: " + "\(match)")
            return match
        }
        return filteredJsonArr
    }
}

protocol RepoDetailViewClosable:Closable{}
extension RepoDetailView{
    func close() {
//        Swift.print("Close")
        _ = FileModifier.write(Config.Bundle.repo.tildePath, RepoView.treeDP.tree.xml.xmlString)/*store the repo xml*/
        Swift.print("💾 Write RepoList to: repo.xml")
        self.removeFromSuperview()
    }
}

//private class Utils{
//    /**
//     * New
//     */
//    static func checkedState(_ repoItem:RepoItem,_ idx3d:[Int],_ key:String) -> CheckedState  {
//        let isFolder = TreeDPAsserter.hasChildren(RepoView.treeDP, idx3d)
//        if isFolder {
//            guard let tree:Tree = TreeParser.child(RepoView.treeDP.tree, idx3d) else {fatalError("err")}
//            let descendants:[Tree] = TreeUtils.flattened(tree)/*find all projects under this folder*/
////            Swift.print("descendants.count: " + "\(descendants.count)")
//            let someAreChecked:Bool = descendants.first(where: {$0.props![key] == "true"}) != nil
////            Swift.print("someAreChecked: " + "\(someAreChecked)")
//            let someAreUnChecked:Bool = descendants.first(where: {$0.props![key] == "false"}) != nil
////            Swift.print("someAreUnChecked: " + "\(someAreUnChecked)")
//            let state:CheckedState = {/*//set the data based on what the sum of bools are for all projects.*/
//                if someAreChecked && someAreUnChecked {return .mix }
//                else if someAreChecked {return .checked}
//                else {return .none}/*someAreUnChecked {.none}*/
//            }()
//            return state
//        }else {
//            guard let prop:Bool = repoItem[key] else {fatalError("repoItem does not have key: \(key)")}
////            Swift.print("repoItem: " + "\(repoItem)")
////            Swift.print("prop: " + "\(prop)")
//            return prop ? .checked : .none
//        }
//        
//        
//    }
//}

