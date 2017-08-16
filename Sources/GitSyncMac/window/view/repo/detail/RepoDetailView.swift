import Foundation
@testable import Utils
@testable import Element

class RepoDetailView:Element,Closable {
    override func resolveSkin() {
        super.resolveSkin()
        UnFoldUtils.unFold(Config.Bundle.app,"repoDetailView",self)
    }
    /**
     * Modifies the dataProvider item on UI change
     * TODO: ⚠️️ enumify this method? at least use switch
     */
    override func onEvent(_ event:Event) {
        //Swift.print("RepoDetailView.onEvent: type: " + "\(event.type) immediate: \(event.immediate) origin: \(event.origin)")
        let idx3d:[Int] = RepoView.selectedListItemIndex
        guard var attrib:[String:String] = RepoView.treeDP.tree[idx3d]?.props else{
            fatalError("no attribs at: \(idx3d)")
        }
        if event.type == Event.update {/*TextInput*/
            switch true{
            case event.isChildOf(nameText):
                //Swift.print("nameText?.inputText: " + "\(nameText?.inputText)")
                attrib[RepoType.title.rawValue] = nameText?.inputText
            case event.isChildOf(localPathPicker):
                attrib[RepoType.local.rawValue] = localPathPicker?.textInput.inputText
            case event.isChildOf(remoteText):
                attrib[RepoType.remote.rawValue] = remoteText?.inputText
            case event.isChildOf(branchText):
                attrib[RepoType.branch.rawValue] = branchText?.inputText
            default:
                break;
            }
        }else if event.type == CheckEvent.check{/*CheckButtons*/
            switch true{
            case event.isChildOf(activeCheckBoxButton)://TODO: <---use getChecked here
                attrib[RepoType.active.rawValue] = activeCheckBoxButton?.getChecked().str
            case event.isChildOf(messageCheckBoxButton):
                attrib[RepoType.message.rawValue] = messageCheckBoxButton?.getChecked().str
            case event.isChildOf(autoCheckBoxButton):
                attrib[RepoType.auto.rawValue] = autoCheckBoxButton?.getChecked().str
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
                _ = tree
                //Swift.print("title: " + "\(tree.props?[RepoType.title.rawValue])")
                //Swift.print("node.xml.xmlString: " + "\(tree.xml.xmlString)")
            }
        }
    }
}
extension RepoDetailView{
    /**
     * Populates the UI elements with data from the dp item
     * NOTE: Filters groups and items
     */
    func setRepoData(_ idx3d:[Int]){
        //Swift.print("setRepoData(idx3d) ")
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
        //Swift.print("setRepoData(repoItem)")
        /*TextInput*/
        //Swift.print("repoItem.title: " + "\(repoItem.title)")
        nameText?.inputTextArea.setTextValue(repoItem.title)
        localPathPicker?.textInput.setInputText(repoItem.local)
        remoteText?.inputTextArea.setTextValue(repoItem.remote)
        branchText?.inputTextArea.setTextValue(repoItem.branch)
        /*CheckButtons*/
        autoCheckBoxButton?.setChecked(repoItem.auto)
        messageCheckBoxButton?.setChecked(repoItem.message)
        activeCheckBoxButton?.setChecked(repoItem.active)
    }
}
extension RepoDetailView{/*Convenience*/
    var nameText:TextInput? {return self.element(RepoType.title.rawValue)}
    var localPathPicker:FilePicker? {return self.element(RepoType.local.rawValue)}
    var remoteText:TextInput? {return self.element(RepoType.remote.rawValue)}
    var branchText:TextInput? {return self.element(RepoType.branch.rawValue)}
    var autoCheckBoxButton:CheckBoxButton? {return self.element(RepoType.auto.rawValue)}
    var messageCheckBoxButton:CheckBoxButton? {return self.element(RepoType.message.rawValue)}
    var activeCheckBoxButton:CheckBoxButton? {return self.element(RepoType.active.rawValue)}
}
