import Foundation
@testable import Utils
@testable import Element

class RepoDetailView:Element,Closable,UnFoldable {
    override func resolveSkin() {
        super.resolveSkin()
        Unfold.unFold(fileURL: Config.Bundle.structure,path: "repoDetailView",parent: self)
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
        }else if let event = event as? CheckEvent{/*CheckButtons*/
            switch true{
            case event.isChildOf(parentID:Key.active)://TODO: <---use getChecked here
                attrib[RepoType.active.rawValue] = event.isChecked.str
            case event.isChildOf(parentID:Key.message) ://event.isChildOf(messageCheckBoxButton)
                attrib[RepoType.message.rawValue] = event.isChecked.str
            case event.isChildOf(parentID:Key.auto):
                attrib[RepoType.auto.rawValue] = event.isChecked.str
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

