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
//        Swift.print("is child of : \(event.isChildOf(parentID: "template"))")
//        Swift.print("(event.immediate as! ElementKind).id: " + "\((event.immediate as! ElementKind).id)")
        let idx3d:[Int] = RepoView.selectedListItemIndex
        var data:RepoDetailData = RepoDetailData.repoDetailData(treeDP: RepoView.treeDP, idx3d: idx3d)
        
        switch true{
        case event.assert(TextFieldEvent.update,parentID:Key.title):
            data.title = (event as! TextFieldEvent).stringValue
        case event.assert(TextFieldEvent.update,parentID:Key.local):
            data.local = (event as! TextFieldEvent).stringValue
        case event.assert(TextFieldEvent.update,parentID:Key.remote):
            data.remote = (event as! TextFieldEvent).stringValue
        case event.assert(TextFieldEvent.update,parentID:Key.branch):
            data.branch = (event as! TextFieldEvent).stringValue
        case event.assert(TextFieldEvent.update,parentID:Key.template):
//            Swift.print("template : \((event as! TextFieldEvent).stringValue)")
            data.template = (event as! TextFieldEvent).stringValue
        case event.assert(CheckEvent.check,parentID:Key.active):
            data.active = (event as! CheckEvent).isChecked
        case event.assert(CheckEvent.check,parentID:Key.message):
            data.message = (event as! CheckEvent).isChecked
        case event.assert(CheckEvent.check,parentID:Key.auto):
            data.auto = (event as! CheckEvent).isChecked
        default:
            super.onEvent(event)//forward other events
            break;
        }
        if event.assert(.check) || event.assert(.update) {
            RepoView.treeDP.tree[idx3d]!.props = data.dict/*Overrides the cur attribs*/
        }
    }
}
