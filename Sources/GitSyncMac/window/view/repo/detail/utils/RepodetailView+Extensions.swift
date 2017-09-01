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
        
        //what if we store the type and ref, and then use this to 
        /*CheckButtons*/
        self.apply(["autoGroup",Key.auto], repoItem.auto)
        self.apply(["messageGroup",Key.message], repoItem.message)
        
        let isFolder = TreeDPAsserter.hasChildren(RepoView.treeDP, idx3d)
        let activeState:CheckedState = {
            if isFolder {
                
                //set the data based on what the sum of bools are for all projects. 🏀
                //find all projects under this folder
                //you need idx for that
                //and ref to treeDB
                
                guard let tree:Tree = TreeParser.child(RepoView.treeDP.tree, idx3d) else {fatalError("err")}
                //, Parser.descendants()
                let descendants:[Tree] = TreeUtils.flattened(tree)
                
                Swift.print("descendants.count: " + "\(descendants.count)")
                
                var someAreChecked:Bool = false
                var someAreUnChecked:Bool = false
                
                descendants.forEach { (item:Tree) in
                    if let prop = item.props?["active"]  {
                        Swift.print("prop: " + "\(prop)")
                        if prop == "true"{
                            someAreChecked = true
                        }else if prop == "false" {
                            someAreUnChecked = true
                            
                        }
                    }
                    
                }
                Swift.print("someAreChecked: " + "\(someAreChecked)")
                Swift.print("someAreUnChecked: " + "\(someAreUnChecked)")
                let state:CheckedState = {
                    if someAreChecked && someAreUnChecked {return .mix }
                    else if someAreChecked {return .checked}
                    else {return .none}/*someAreUnChecked {.none}*/
                }()
                return state
            }else{
                return repoItem.active ? .checked : .none
            }
            
            
        }()
        Swift.print("activeState.rawValue: " + "\(activeState.rawValue)")
        
        
        
        if let activeUI:CheckBoxButton2 = try? UnfoldParser.instance(parent:self, path:["activeGroup",Key.active]) {activeUI.value = activeState.rawValue}/*, let last = path.last*/
        
//        self.apply(["activeGroup",Key.active], activeState.rawValue) /*data.active*/
        self.apply(["notificationGroup",Key.notification], repoItem.notification)
    }
    /**
     *
     */
    func folderJson(fileURL:String,path:String) -> [[String:Any]]{
        
        guard let jsonDict:[String: Any] = JSONParser.dict(fileURL.content?.json) else{fatalError("fileURL: is incorrect: \(fileURL)")}
        guard let jsonDictItem:Any = jsonDict[path] else{fatalError("path is incorrect: \(path)")}
        guard let jsonArr:[[String:Any]] = JSONParser.dictArr(jsonDictItem) else{fatalError("jsonDictItem: is incorrect")}
        let matchs = ["title","activeGroup","autoGroup","notificationGroup","messageGroup"]
        let filteredJsonArr = jsonArr.filter{
            guard let id:String = $0["id"] as? String else {fatalError("err")}
            Swift.print("id: " + "\(id)")
            let match:Bool = ArrayAsserter.has(matchs, id)
            Swift.print("match: " + "\(match)")
            return match
        }
        return filteredJsonArr
    }
}

protocol RepoDetailViewClosable:Closable{}
extension RepoDetailView{
    func close() {
        _ = FileModifier.write(Config.Bundle.repo.tildePath, RepoView.treeDP.tree.xml.xmlString)/*store the repo xml*/
        Swift.print("💾 Write RepoList to: repo.xml")
        self.removeFromSuperview()
    }
}

