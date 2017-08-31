import Foundation
@testable import Utils
@testable import Element

class RepoDetailView:Element,Closable,UnFoldable {
    let isFolder:Bool
    init(isFolder:Bool, size: CGSize = CGSize(), id: String? = nil) {
        self.isFolder = isFolder
        super.init(size: size, id: id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        
        
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
        var data:RepoItem = RepoItem.repoItem(treeDP: RepoView.treeDP, idx3d: idx3d)
        
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
    
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
}
