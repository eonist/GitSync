import Foundation
@testable import Utils
@testable import Element

extension RepoDetailView{
    /**
     * Populates the UI elements with data from the dp item
     * NOTE: Filters groups and items
     */
    func setRepoData(_ idx3d:[Int]){
        RepoView.selectedListItemIndex = idx3d
        let repoDetailData = RepoItem.repoItem(treeDP: RepoView.treeDP, idx3d: idx3d)
        setRepoData(repoDetailData)
    }
    /**
     * Populates the UI elements with data from the dp item
     * NOTE: Uses the Unfold lib to set data
     */
    private func setRepoData(_ data:RepoItem){
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
}

protocol RepoDetailViewClosable:Closable{}
extension RepoDetailView{
    func close() {
        _ = FileModifier.write(Config.Bundle.repo.tildePath, RepoView.treeDP.tree.xml.xmlString)/*store the repo xml*/
        Swift.print("💾 Write RepoList to: repo.xml")
        self.removeFromSuperview()
    }
}

