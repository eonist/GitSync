import Foundation
@testable import Utils
@testable import Element

class RepoDetailView:Element {
    var nameTextInput:TextInput?
    var localPathTextInput:TextInput?
    var remotePathTextInput:TextInput?
    var branchTextInput:TextInput?
    var broadCastCheckBoxButton:CheckBoxButton?
    var subscribeCheckBoxButton:CheckBoxButton?
    var autoMessageCheckBoxButton:CheckBoxButton?
    var autoSyncCheckBoxButton:CheckBoxButton?
    
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        nameTextInput = addSubView(TextInput(width, 32, "Name: ", "", self))
        localPathTextInput = addSubView(TextInput(width, 32, "Local-path: ", "", self))
        remotePathTextInput = addSubView(TextInput(width, 32, "Remote-path: ", "", self))
        branchTextInput = addSubView(TextInput(width, 32, "Branch: ", "", self))//branch-text-input: master is default, set to dev for instance
        subscribeCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Upload:", false, self))
        broadCastCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Download:", false, self))//to disable an item uncheck broadcast and subscribe
        autoMessageCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Auto-message:", false, self))//if auto sync is off then a manual commit popup dialog will appear (with pre-populated text)
        autoSyncCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Auto-sync:", true, self))
    }
    /**
     * Populates the UI elements with data from the dp item
     */
    func setRepoData(_ repoItem:RepoItem){
        nameTextInput!.inputTextArea!.setTextValue(repoItem.title)
        localPathTextInput!.inputTextArea!.setTextValue(repoItem.localPath)
        remotePathTextInput!.inputTextArea!.setTextValue(repoItem.remotePath)
        branchTextInput!.inputTextArea!.setTextValue(repoItem.branch)
        broadCastCheckBoxButton!.setChecked(repoItem.broadcast)
        subscribeCheckBoxButton!.setChecked(repoItem.subscribe)
        autoMessageCheckBoxButton!.setChecked(repoItem.autoSync)
        //autoSyncIntervalLeverSpinner!.setValue(repoData["interval"]!.cgFloat)
    }
    /**
     * Modifies the dataProvider item on UI change
     */
    override func onEvent(_ event:Event) {
        let i:[Int] = RepoView.selectedListItemIndex
        let node:Node = RepoView.node!
        var attrib:[String:String] = XMLParser.attributesAt(node.xml, i)!
        switch true{
            case event.assert(Event.update,immediate:nameTextInput):
                attrib["title"] = (event as! TextFieldEvent).stringValue
            case event.assert(Event.update,immediate:localPathTextInput):
                attrib["local-path"] = (event as! TextFieldEvent).stringValue
            case event.assert(Event.update,immediate:remotePathTextInput):
                attrib["remote-path"] = (event as! TextFieldEvent).stringValue
            case event.assert(Event.update,immediate:remotePathTextInput):
                attrib["branch"] = (event as! TextFieldEvent).stringValue
            case event.assert(CheckEvent.check,immediate:broadCastCheckBoxButton):
                attrib["broadcast"] = String((event as! CheckEvent).isChecked)
            case event.assert(CheckEvent.check,immediate:subscribeCheckBoxButton):
                attrib["subscribe"] = String((event as! CheckEvent).isChecked)
            case event.assert(CheckEvent.check,immediate:autoMessageCheckBoxButton):
                attrib["auto-sync"] = String((event as! CheckEvent).isChecked)
            //case event.assert(SpinnerEvent.change, autoSyncIntervalLeverSpinner):
                //dp.setValue(i, "interval", (event as! SpinnerEvent).value.string)
            default:
                break;
        }
        node.setAttributeAt(i, attrib)
    }
}
