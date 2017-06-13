import Foundation
@testable import Utils
@testable import Element

class RepoDetailView:Element {
    override func resolveSkin() {
        super.resolveSkin()
        UnFoldUtils.unfold("~/Desktop/gitsync.json","repoDetailView",self)
    }
    /**
     * Modifies the dataProvider item on UI change
     * TODO: Collectivly test for event type, then anrrow down on origin
     * TODO: Might need to change to origin testing since these items now are in the container. So event.orgin === downloadButoon.checkBox
     * TODO: ⚠️️ enumify this method? at least usw switch
     */
    override func onEvent(_ event:Event) {
        Swift.print("onEvent: type: " + "\(event.type) immediate: \(event.immediate) origin: \(event.origin)")
        let idx3d:[Int] = RepoView.selectedListItemIndex
        guard var attrib:[String:String] = RepoView.treeDP.tree[idx3d]?.props else{
            fatalError("no attribs at: \(idx3d)")
        }
        if event.type == Event.update {
            switch true{
            /*TextInput*/
            case event.isChildOf(nameText):
                attrib[RepoItemType.title] = nameText?.inputString
            case event.isChildOf(localText):
                attrib[RepoItemType.localPath] = localText?.inputString
            case event.isChildOf(remoteText):
                attrib[RepoItemType.remotePath] = remoteText?.inputString
            case event.isChildOf(branchText):
                attrib[RepoItemType.branch] = branchText?.inputString
            default:
                break;
            }
        }else if event.type == CheckEvent.check{
            switch true{
            /*CheckButtons*/
            case event.isChildOf(activeCheckBoxButton)://TODO: <---use getChecked here
                attrib[RepoItemType.active] = activeCheckBoxButton?.getChecked().str
            case event.isChildOf(messageCheckBoxButton):
                attrib[RepoItemType.autoCommitMessage] = messageCheckBoxButton?.getChecked().str
            case event.isChildOf(autoCheckBoxButton):
                attrib[RepoItemType.pullToAutoSync] = autoCheckBoxButton?.getChecked().str
            default:
                break;
            }
        }else{
            super.onEvent(event)//forward other events
        }
        if(event.type == CheckEvent.check || event.type == Event.update){
            //Swift.print("✨ Update dp with: attrib: " + "\(attrib)")
            RepoView.treeDP.tree[idx3d]!.props = attrib/*Overrides the cur attribs*///RepoView.node.setAttributeAt(i, attrib)
            if let tree:Tree = RepoView.treeDP.tree[idx3d]{
                Swift.print("title: " + "\(tree.props?["title"])")
                //Swift.print("node.xml.xmlString: " + "\(tree.xml.xmlString)")
            }
        }
    }
}
extension RepoDetailView{
    /**
     * NOTE: Filters groups and items
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
        /*TextInput*/
        nameText?.inputTextArea.setTextValue(repoItem.title)
        localText?.inputTextArea.setTextValue(repoItem.localPath)
        remoteText?.inputTextArea.setTextValue(repoItem.remotePath)
        branchText?.inputTextArea.setTextValue(repoItem.branch)
        /*CheckButtons*/
        autoCheckBoxButton?.setChecked(!repoItem.pullToAutoSync)
        messageCheckBoxButton?.setChecked(repoItem.autoCommitMessage)
        activeCheckBoxButton?.setChecked(repoItem.active)
    }
}
extension RepoDetailView{/*Convenience*/
    var nameText:TextInput? {return self.element("name")}
    var localText:TextInput? {return self.element("local")}
    var remoteText:TextInput? {return self.element("remote")}
    var branchText:TextInput? {return self.element("branch")}
    var autoCheckBoxButton:CheckBoxButton? {return self.element("auto")}
    var messageCheckBoxButton:CheckBoxButton? {return self.element("message")}
    var activeCheckBoxButton:CheckBoxButton? {return self.element("active")}
}
