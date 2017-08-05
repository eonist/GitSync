import Foundation
@testable import Utils
@testable import Element

class CommitDialogView:Element,UnFoldable {
    override func resolveSkin() {
        Swift.print("CommitDialogView.resolveSkin()")
        super.resolveSkin()
        UnFoldUtils.unFold(Config.Bundle.app,"commitDialogView",self)
        let data:[String:[String:Any]] = [
            "repo":["inputText":"Element iOS"],
            "title":["inputText":"Added support for padding"],
            "desc":["inputText":"4 Files changed"]
        ]
        self.data = data
    }
    var data:[String:Any] {
        get{fatalError("not avialbe")}
        set{
            if let data = newValue as? [String:[String:Any]] {
                UnFoldUtils.applyData(self, data)
            }
        }
    }
    /**
     * EventHandler for the okButton click event
     */
    func onOKButtonClick(){
        //AutoSync.shared.iterateMessageCount()
        Nav.setView(.main(.commit))
    }
    override func onEvent(_ event:Event) {
        if event.assert(.upInside, id: "ok"){
            Swift.print("do commit stuff here")
            Swift.print("remove commit dialog from view")
            onOKButtonClick()
        }else if event.assert(.upInside, id: "cancel"){
            Swift.print("stop the auto sync process")
            Swift.print("remove commit dialog from view")
            fatalError("not supported yet")
            //Nav.setView(.main(.commit))
        }
    }
}
