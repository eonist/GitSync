import Foundation
@testable import Utils
@testable import Element

extension RepoDetailView{
    /**
     * Populates the UI elements with data from the dp item
     * NOTE: Uses the Unfold lib to set data
     */
    public func setRepoData(repoItem data:RepoItem){
        Swift.print("setRepoData(repoItem)")
        /*TextInput*/
        self.apply([Key.title],data.title)
        self.apply([Key.local],data.local)
        self.apply([Key.remote],data.remote)
        self.apply([Key.branch],data.branch)
        self.apply([Key.template],data.template)
        /*CheckButtons*/
        self.apply(["autoGroup",Key.auto], data.auto)
        self.apply(["messageGroup",Key.message], data.message)
        self.apply(["activeGroup",Key.active], data.active)
        self.apply(["notificationGroup",Key.notification], data.notification)
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

