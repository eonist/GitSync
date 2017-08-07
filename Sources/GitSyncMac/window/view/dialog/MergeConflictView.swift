import Foundation
@testable import Utils
@testable import Element

class MergeConflictView:Element,UnFoldable{
    override func resolveSkin() {
        Swift.print("MergeConflictView.resolveSkin()")
        super.resolveSkin()
        UnFoldUtils.unFold(Config.Bundle.app,"mergeConflictView",self)
        Swift.print("unfold completed")
        
        self.apply([Key.issue,Text.Key.text], "Conflict: Local file is older than the remote file")
        self.apply([Key.file,Text.Key.text], "File: AppDelegate.swift")
        self.apply([Key.repo,Text.Key.text], "Repository: Element - iOS")
        
        selectGroup = SelectGroup()
        let selectGroup:SelectGroup = SelectGroup([radioButton1,radioButton2],radioButton2)
        func onSelectGroupChange(event:Event){
            Swift.print("event.selectable: " + "\(event)")
        }
        selectGroup.event = onSelectGroupChange
    }
    override func onEvent(_ event:Event) {
        if event.assert(.upInside, id: "ok"){
            onOKButtonClick()
        }else if event.assert(.upInside, id: "cancel"){
            fatalError("not yet supported")
        }else if event.assert(SelectEvent.select){
            
        }
    }
}
extension MergeConflictView{
    enum Key{
        static let issue = "issueText"
        static let file = "fileText"
        static let repo = "repoText"
    }
    /**
     * EventHandler for the okButton click event
     */
    func onOKButtonClick(){
        //retrive state of radioBUtton and CheckBoxButtons
        
        //iterate merge process along see legacy code
        if let curPrompt = StyleTestView.shared.currentPrompt {curPrompt.removeFromSuperview()}//remove promptView from window
    }
}
