import Foundation
@testable import Utils
@testable import Element
/**
 * MERGE Conflict dialog view
 * TODO: ⚠️️ Make the review buttons as a clickable text in the keep radiobuttons.
 * TODO: ⚠️️ Inline the radiobuttons: Keep: (x) local, () remote, () both
 * TODO: ⚠️️ Remove the cancel button and enable the close button again
 */
class MergeConflictView:Element,UnFoldable,Closable{
    lazy var radioButtonGroup:SelectGroup = {//TODO: ⚠️️  move this into an extension
        let buttons:[RadioButton] = ElementParser.children(self)
        let group = SelectGroup(buttons,buttons.first)
        group.addHandler(type: SelectGroupEvent.change, self.onSelectGroupChange)
        return group
    }()
    lazy var checkBoxButtonGroup:CheckGroup = {//TODO: ⚠️️  move this into an extension
        let buttons:[CheckBoxButton] = ElementParser.children(self)
        let group = CheckGroup(buttons)
        group.addHandler(type: SelectGroupEvent.change, self.onCheckGroupChange)
        return group
    }()
    override func resolveSkin() {
        Swift.print("MergeConflictView.resolveSkin()")
        super.resolveSkin()
        UnFoldUtils.unFold(Config.Bundle.app,"mergeConflictView",self)
        Swift.print("unfold completed")
        
        self.apply([Key.issue,Text.Key.text], "Conflict: Local file is older than the remote file")
        self.apply([Key.file,Text.Key.text], "File: AppDelegate.swift")
        self.apply([Key.repo,Text.Key.text], "Repository: Element - iOS")
        
        _ = radioButtonGroup
    }
    override func onEvent(_ event:Event) {
        if event.assert(.upInside, id: "ok"){
            onOKButtonClick()
        }else if event.assert(.upInside, id: "cancel"){
            fatalError("not yet supported")
        }/*else if event.assert(SelectEvent.select){
         
        }*/
    }
}
extension MergeConflictView{
    func setData(_ mergeConflict:MergeConflict){
        Swift.print("MergeConflictView.setData")
        self.apply([Key.issue], mergeConflict.issue)
        self.apply([Key.file], mergeConflict.file)
        self.apply([Key.repo], mergeConflict.repo)
    }
    enum Key{
        static let issue = "issueText"
        static let file = "fileText"
        static let repo = "repoText"
        static let keepLocal = "keepLocalVersion"
        static let keepRemote = "keepRemoteVersion"
        static let keepMixed = "keepMixedVersion"
        static let applyAllConflicts = "applyAllConflicts"
        static let applyAllRepos = "applyAllRepos"
    }
    func onSelectGroupChange(event:Event){
        Swift.print("onSelectGroupChange event.selectable: " + "\(event)")
    }
    func onCheckGroupChange(event:Event){/*this is the event handler*/
        Swift.print("onSelectGroupChange event.selectable: " + "\(event)")
    }
    /**
     * EventHandler for the okButton click event
     */
    func onOKButtonClick(){
        Swift.print("onOKButtonClick")
        
        
        
        let selectedRadioButtonId:String = (radioButtonGroup.selected as? ElementKind)?.id ?? {fatalError("error")}()
        Swift.print("selectedRadioButtonId: " + "\(String(describing: selectedRadioButtonId))")
        
        let isApplyAllConflictsChecked:Bool = self.retrieve([Key.applyAllConflicts])  ?? {fatalError("error")}()
        Swift.print("isApplyAllConflictsChecked: " + "\(String(describing: isApplyAllConflictsChecked))")
        let isApplyApplyAllReposChecked:Bool = self.retrieve([Key.applyAllRepos]) ?? {fatalError("error")}()
        Swift.print("isApplyApplyAllReposChecked: " + "\(String(describing: isApplyApplyAllReposChecked))")
        
        
        defer{
            let strategy = MergeConflictView.strategy(isApplyAllConflictsChecked,selectedRadioButtonId)
            MergeReslover.shared.processMergeStrategy(strategy)
        }
        
        if let curPrompt = StyleTestView.shared.currentPrompt {curPrompt.removeFromSuperview()}//remove promptView from window
          
        
    }
}
extension MergeConflictView{
    /**
     *
     */
    static func strategy(_ applyToAll:Bool,_ id:String) -> MergeReslover.Option{
        let option:MergeReslover.Option = {
            if applyToAll {
                return MergeReslover.Option.all(
                    {
                        if id == Key.keepLocal {
                            return .local
                        }else if id == Key.keepRemote{
                            return .remote
                        }else{//Key.keepMixed
                            return .mix
                        }
                    }()
                )
            }else {
                return MergeReslover.Option.singular(
                    {
                        if id == Key.keepLocal {
                            return .local
                        }else if id == Key.keepRemote{
                            return .remote
                        }else{//Key.keepMixed
                            return .mix
                        }
                    }()
                )
                
            }
        }()
        return option
    }
}
