import Foundation
@testable import Utils
@testable import Element

class RepoDetailView:Element {
    override func resolveSkin() {
        Swift.print("RepoDetailView.resolveSkin()")
        super.resolveSkin()//self.skin = SkinResolver.skin(self)
        
        JSONParser.dictArr(JSONParser.dict("~/Desktop/gitsync.json".content?.json)?["repoDetailView"])?.forEach{
            if let element:Element = UnFoldUtils.unFold($0) {
                addSubview(element)
            }
        }
    }
}
extension RepoDetailView{
    /**
     *
     */
    func setRepoData(_ idx3d:[Int]){
        RepoView.selectedListItemIndex = idx3d
        //TODO: Use the RepoItem on the bellow line see AutoSync class for implementation
        if let tree:Tree = RepoView.treeDP.tree[idx3d], let repoItemDict = tree.props{//NodeParser.dataAt(treeList!.node, selectedIndex)
            var repoItem:RepoItem
            if !tree.children.isEmpty {/*Support for folders*/
                repoItem = RepoItem()
                if let title:String = repoItemDict[RepoItemType.title] {repoItem.title = title}
                if let active:String = repoItemDict[RepoItemType.active] {repoItem.active = active.bool}
            }else{
                repoItem = RepoUtils.repoItem(repoItemDict)
            }
            setRepoData(repoItem)
        }
    }
    /**
     * Populates the UI elements with data from the dp item
     */
    private func setRepoData(_ repoItem:RepoItem){
        nameText?.inputTextArea.setTextValue(repoItem.title)
        localText?.inputTextArea.setTextValue(repoItem.localPath)
        remoteText?.inputTextArea.setTextValue(repoItem.remotePath)
        branchText?.inputTextArea.setTextValue(repoItem.branch)
        /*CheckButtons*/
        //uploadCheckBoxButton?.setChecked(repoItem.upload)
        /*downloadCheckBoxButton.setChecked(repoItem.download)
         messageCheckBoxButton.setChecked(repoItem.autoCommitMessage)
         intervalCheckBoxButton.setChecked(repoItem.autoSyncInterval)
         autoSyncIntervalLeverSpinner.setValue(repoItem.interval.cgFloat)
         activeCheckBoxButton.setChecked(repoItem.active)
         pullCheckBoxButton.setChecked(repoItem.pullToAutoSync)
         fileChangeCheckBoxButton.setChecked(repoItem.fileChange)*/
    }
}
extension RepoDetailView{
    var nameText:TextInput? {return self.element("name")}
    var localText:TextInput? {return self.element("local")}
    var remoteText:TextInput? {return self.element("remote")}
    var branchText:TextInput? {return self.element("branch")}
    var uploadCheckBoxButton:CheckBoxButton? {return self.element("upload")}
}
