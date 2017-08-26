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
        let repoDetailData = RepoDetailData.repoDetailData(treeDP: RepoView.treeDP, idx3d: idx3d)
        setRepoData(repoDetailData)
    }
    /**
     * Populates the UI elements with data from the dp item
     * TODO: ⚠️️ Use the Unfold lib to set data not direct refs like this
     */
    private func setRepoData(_ data:RepoDetailData){
        Swift.print("setRepoData(repoItem)")
        /*TextInput*/
        self.apply([Key.title],data.title)
        self.apply([Key.local],data.local)
        self.apply([Key.remote],data.remote)
        self.apply([Key.branch],data.branch)
        /*CheckButtons*/
        self.apply(["autoGroup",Key.auto], data.auto)
        self.apply(["messageGroup",Key.message], data.message)
        self.apply(["activeGroup",Key.active], data.active)
    }
}
