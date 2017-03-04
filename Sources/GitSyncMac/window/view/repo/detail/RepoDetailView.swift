import Foundation
@testable import Utils
@testable import Element

class RepoDetailView:Element {
    var nameTextInput:TextInput?
    var localPathTextInput:TextInput?
    var remotePathTextInput:TextInput?
    var branchTextInput:TextInput?
    var uploadCheckBoxButton:CheckBoxButton?
    var downloadCheckBoxButton:CheckBoxButton?
    /*CheckButtons*/
    var activeCheckBoxButton:CheckBoxButton?
    var messageCheckBoxButton:CheckBoxButton?
    var intervalCheckBoxButton:CheckBoxButton?
    var fileChangeCheckBoxButton:CheckBoxButton?
    var pullCheckBoxButton:CheckBoxButton?
    /*LeverSpinner*/
    var autoSyncIntervalLeverSpinner:LeverSpinner?
    
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        nameTextInput = addSubView(TextInput(width, 32, "Name: ", "", self))
        localPathTextInput = addSubView(TextInput(width, 32, "Local-path: ", "", self))
        remotePathTextInput = addSubView(TextInput(width, 32, "Remote-path: ", "", self))
        branchTextInput = addSubView(TextInput(width, 32, "Branch: ", "", self))//branch-text-input: master is default, set to dev for instance
        autoSyncIntervalLeverSpinner = addSubView(LeverSpinner(width, 32, "Interval: ", 0, 1, Int.min.cgFloat, Int.max.cgFloat, 0, 100, 200, self))
        /*CheckButtons*/
        
        downloadCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Upload:", false, self))
        uploadCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Download:", false, self))//to disable an item uncheck broadcast and subscribe
        /*LeverSpinner*/
        pullCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Pull:", false, self))
        fileChangeCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Change:", false, self))
        messageCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Message:", false, self))
        activeCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Active:", false, self))//if auto sync is off then a manual commit popup dialog will appear (with pre-populated text)
        intervalCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Interval:", false, self))
    }
    /**
     * Populates the UI elements with data from the dp item
     */
    func setRepoData(_ repoItem:RepoItem){
        nameTextInput!.inputTextArea!.setTextValue(repoItem.title)
        localPathTextInput!.inputTextArea!.setTextValue(repoItem.localPath)
        remotePathTextInput!.inputTextArea!.setTextValue(repoItem.remotePath)
        branchTextInput!.inputTextArea!.setTextValue(repoItem.branch)
        /*CheckButtons*/
        uploadCheckBoxButton!.setChecked(repoItem.upload)
        downloadCheckBoxButton!.setChecked(repoItem.download)
        messageCheckBoxButton!.setChecked(repoItem.autoCommitMessage)
        intervalCheckBoxButton!.setChecked(repoItem.autoSyncInterval)
        autoSyncIntervalLeverSpinner!.setValue(repoItem.interval.cgFloat)
        activeCheckBoxButton!.setChecked(repoItem.active)
        pullCheckBoxButton!.setChecked(repoItem.pullToAutoSync)
        fileChangeCheckBoxButton!.setChecked(repoItem.fileChange)
    }
    /**
     * Modifies the dataProvider item on UI change
     */
    override func onEvent(_ event:Event) {
        let i:[Int] = RepoView.selectedListItemIndex
        let node:Node = RepoView.node
        var attrib:[String:String] = XMLParser.attributesAt(node.xml, i)!
        switch true{
            case event.assert(Event.update,immediate:nameTextInput):
                attrib[RepoItemType.title] = (event as! TextFieldEvent).stringValue
            case event.assert(Event.update,immediate:localPathTextInput):
                attrib[RepoItemType.localPath] = (event as! TextFieldEvent).stringValue
            case event.assert(Event.update,immediate:remotePathTextInput):
                attrib[RepoItemType.remotePath] = (event as! TextFieldEvent).stringValue
            case event.assert(Event.update,immediate:remotePathTextInput):
                attrib[RepoItemType.branch] = (event as! TextFieldEvent).stringValue
            /*CheckButtons*/
            case event.assert(CheckEvent.check,immediate:uploadCheckBoxButton):
                attrib[RepoItemType.upload] = String((event as! CheckEvent).isChecked)
            case event.assert(CheckEvent.check,immediate:downloadCheckBoxButton):
                attrib[RepoItemType.download] = String((event as! CheckEvent).isChecked)
            case event.assert(CheckEvent.check,immediate:activeCheckBoxButton):
                attrib[RepoItemType.active] = String((event as! CheckEvent).isChecked)
            case event.assert(CheckEvent.check,immediate:messageCheckBoxButton):
                attrib[RepoItemType.autoCommitMessage] = String((event as! CheckEvent).isChecked)
            case event.assert(CheckEvent.check,immediate:pullCheckBoxButton):
                attrib[RepoItemType.pullToAutoSync] = String((event as! CheckEvent).isChecked)
            case event.assert(CheckEvent.check,immediate:fileChangeCheckBoxButton):
                attrib[RepoItemType.fileChange] = String((event as! CheckEvent).isChecked)
            case event.assert(CheckEvent.check,immediate:intervalCheckBoxButton):
                attrib[RepoItemType.autoSyncInterval] = String((event as! CheckEvent).isChecked)
            /*LeverSpinner*/
            case event.assert(SpinnerEvent.change, autoSyncIntervalLeverSpinner):
                attrib[RepoItemType.interval] = (event as! SpinnerEvent).value.string
            default:
                break;
        }
        node.setAttributeAt(i, attrib)
    }
}
