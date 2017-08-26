import Foundation
@testable import Utils
@testable import Element

extension RepoDetailView{
    /**
     * Populates the UI elements with data from the dp item
     * NOTE: Filters groups and items
     */
    func setRepoData(_ idx3d:[Int]){
//        Swift.print("setRepoData(idx3d) ")
        RepoView.selectedListItemIndex = idx3d
        //TODO: Use the RepoItem on the bellow line see AutoSync class for implementation
        if let tree:Tree = RepoView.treeDP.tree[idx3d], let repoItemDict = tree.props{//NodeParser.dataAt(treeList!.node, selectedIndex)
            var repoItem:RepoItem
            let hasIsOpenAttrib:Bool = TreeAsserter.hasAttribute(RepoView.treeDP.tree, idx3d, "isOpen")
            
            Swift.print("hasIsOpenAttrib: " + "\(hasIsOpenAttrib)")
            if !tree.children.isEmpty  || hasIsOpenAttrib {/*Support for folders*/
                repoItem = RepoItem()
                if let title:String = repoItemDict[RepoType.title.rawValue] {repoItem.title = title}
                if let active:String = repoItemDict[RepoType.active.rawValue] {repoItem.active = active.bool}
            }else{
                repoItem = RepoUtils.repoItem(repoItemDict)
            }
            setRepoData(repoItem)
        }
    }
    /**
     * Populates the UI elements with data from the dp item
     * TODO: ⚠️️ Use the Unfold lib to set data not direct refs like this
     */
    private func setRepoData(_ repoItem:RepoItem){
        Swift.print("setRepoData(repoItem)")
        /*TextInput*/
        //Swift.print("repoItem.title: " + "\(repoItem.title)")
        nameText?.inputTextArea.setTextValue(repoItem.title)
        localPathPicker?.textInput.setInputText(repoItem.local)
        remoteText?.inputTextArea.setTextValue(repoItem.remote)
        branchText?.inputTextArea.setTextValue(repoItem.branch)
        /*CheckButtons*/
        //        autoCheckBoxButton?.setChecked(repoItem.auto)
        self.apply(["autoGroup",Key.auto], repoItem.auto)
        self.apply(["messageGroup",Key.message], repoItem.message)
        self.apply(["activeGroup",Key.active], repoItem.active)
//        messageCheckBoxButton?.setChecked(repoItem.message)
//        activeCheckBoxButton?.setChecked(repoItem.active)
    }
}
extension RepoDetailView{/*Convenience*/
    var nameText:TextInput? {return self.element(RepoType.title.rawValue)}
    var localPathPicker:FilePicker? {return self.element(RepoType.local.rawValue)}
    var remoteText:TextInput? {return self.element(RepoType.remote.rawValue)}
    var branchText:TextInput? {return self.element(RepoType.branch.rawValue)}
    //    var autoCheckBoxButton:CheckBoxButton? {return self.element(RepoType.auto.rawValue)}
//    var messageCheckBoxButton:CheckBoxButton? {return self.element(RepoType.message.rawValue)}
//    var activeCheckBoxButton:CheckBoxButton? {return self.element(RepoType.active.rawValue)}
}
