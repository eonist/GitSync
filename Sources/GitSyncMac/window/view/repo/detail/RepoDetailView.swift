import Foundation
@testable import Utils
@testable import Element

class RepoDetailView:Element,Closable,UnFoldable {
    
    
    override func resolveSkin() {
        super.resolveSkin()
        let idx3d = RepoView.selectedListItemIndex
        
        let isFolder = TreeDPAsserter.hasChildren(RepoView.treeDP, idx3d)
        
        if isFolder {
            let folderJson = self.folderJson(fileURL: Config.Bundle.structure, path: "repoDetailView")
            Unfold.unFold(jsonArr:folderJson, parent: self)
        }else{
            Unfold.unFold(fileURL:Config.Bundle.structure, path:"repoDetailView", parent:self)
        }
    }
    
    /**
     * Modifies the dataProvider item on UI change
     */
    override func onEvent(_ event:Event) {
//        Swift.print("RepoDetailView.onEvent: type: " + "\(event.type) immediate: \(event.immediate) origin: \(event.origin)")
        let idx3d:[Int] = RepoView.selectedListItemIndex
        var repoItem:RepoItem = RepoItem.repoItem(treeDP: RepoView.treeDP, idx3d: idx3d)
        
        switch true{
        case event.assert(TextFieldEvent.update,parentID:Key.title):/*title*/
            repoItem.title = (event as! TextFieldEvent).stringValue
        case event.assert(TextFieldEvent.update,parentID:Key.local):/*local*/
            repoItem.local = (event as! TextFieldEvent).stringValue
        case event.assert(TextFieldEvent.update,parentID:Key.remote):/*remote*/
            repoItem.remote = (event as! TextFieldEvent).stringValue
        case event.assert(TextFieldEvent.update,parentID:Key.branch):/*branch*/
            repoItem.branch = (event as! TextFieldEvent).stringValue
        case event.assert(TextFieldEvent.update,parentID:Key.template):/*template*/
            repoItem.template = (event as! TextFieldEvent).stringValue
        case event.assert(.check2):
            repoItem = onCheckEvent(event as! CheckEvent2,&repoItem)
        default:
            super.onEvent(event)/*forward other events*/
            break;
        }
        if event.assert(.check) || event.assert(.check2) || event.assert(.update) {
            RepoView.treeDP.tree[idx3d]!.props = repoItem.dict/*Overrides the cur attribs*/
        }
        if event.assert(.check2) {
            //Swift.print("repoItem.active: " + "\(RepoItem.repoItem(treeDP: RepoView.treeDP, idx3d: idx3d).active)")
        }
    }
    /**
     * New
     */
    func onCheckEvent(_ event:CheckEvent2,_ repoItem: inout RepoItem) -> RepoItem{
        let idx3d = RepoView.selectedListItemIndex
        let isFolder = TreeDPAsserter.hasChildren(RepoView.treeDP, idx3d)
        
        func closure(_ key:String,_ value:Bool) {//this method could be usefull for other UI components too, by using generics
            repoItem[key] = value//set the root
            if isFolder {/*if folder then,set all descendant repoItems to the origin state*/
                TreeModifier.applyAll(tree: &RepoView.treeDP.tree, idx3d: idx3d, apply: {/*Swift.print($0.props?["title"]);*/$0.props?[key] = value.str})
            }
        }
        
        switch true{
        case event.assert(parentID: Key.active):/*active*/
            closure(Key.active,event.checked)
//            Swift.print("repoItem.active: " + "\(repoItem.active)")
        case event.assert(parentID:Key.message):/*message*/
            closure(Key.message,event.checked)
        case event.assert(parentID:Key.auto):/*auto*/
            closure(Key.auto,event.checked)
        case event.assert(parentID:Key.notification):/*notification*/
            closure(Key.notification,event.checked)
        default:
            break;
        }
        return repoItem
    }
}
