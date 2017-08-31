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
     */
    override func onEvent(_ event:Event) {
//        Swift.print("RepoDetailView.onEvent: type: " + "\(event.type) immediate: \(event.immediate) origin: \(event.origin)")
        let idx3d:[Int] = RepoView.selectedListItemIndex
        var data:RepoItem = RepoItem.repoItem(treeDP: RepoView.treeDP, idx3d: idx3d)
        
        //figure out why local and notification are not added to data. 🏀
        
        switch true{
        case event.assert(TextFieldEvent.update,parentID:Key.title):
            data.title = (event as! TextFieldEvent).stringValue
        case event.assert(TextFieldEvent.update,parentID:Key.local):
//            Swift.print("set local")
            data.local = (event as! TextFieldEvent).stringValue
        case event.assert(TextFieldEvent.update,parentID:Key.remote):
            data.remote = (event as! TextFieldEvent).stringValue
        case event.assert(TextFieldEvent.update,parentID:Key.branch):
            data.branch = (event as! TextFieldEvent).stringValue
        case event.assert(TextFieldEvent.update,parentID:Key.template):
            data.template = (event as! TextFieldEvent).stringValue
        case event.assert(CheckEvent.check,parentID:Key.active):
            data.active = (event as! CheckEvent).isChecked
        case event.assert(CheckEvent.check,parentID:Key.message):
            data.message = (event as! CheckEvent).isChecked
        case event.assert(CheckEvent.check,parentID:Key.auto):
            data.auto = (event as! CheckEvent).isChecked
        case event.assert(CheckEvent.check,parentID:Key.notification):
//            Swift.print("set notification: ")
            data.notification = (event as! CheckEvent).isChecked
        default:
            super.onEvent(event)//forward other events
            break;
        }
        if event.assert(.check) || event.assert(.update) {
            RepoView.treeDP.tree[idx3d]!.props = data.dict/*Overrides the cur attribs*/
        }
    }
}
