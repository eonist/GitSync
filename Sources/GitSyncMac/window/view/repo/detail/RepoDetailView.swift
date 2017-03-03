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
    var changeCheckBoxButton:CheckBoxButton?
    var pullCheckBoxButton:CheckBoxButton?
    /*LeverSpinner*/
    var autoSyncIntervalLeverSpinner:LeverSpinner?
    
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        nameTextInput = addSubView(TextInput(width, 32, "Name: ", "", self))
        localPathTextInput = addSubView(TextInput(width, 32, "Local-path: ", "", self))
        remotePathTextInput = addSubView(TextInput(width, 32, "Remote-path: ", "", self))
        branchTextInput = addSubView(TextInput(width, 32, "Branch: ", "", self))//branch-text-input: master is default, set to dev for instance
        downloadCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Upload:", false, self))
        uploadCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Download:", false, self))//to disable an item uncheck broadcast and subscribe
        
        //active
        activeCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Active:", false, self))//if auto sync is off then a manual commit popup dialog will appear (with pre-populated text)
        //Message
        messageCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Message:", false, self))
        //interval
        intervalCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Interval:", false, self))
        //change
        changeCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Change:", false, self))
        //pull
        pullCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Pull:", false, self))
        //Interval - spinner
        autoSyncIntervalLeverSpinner = addSubView(LeverSpinner(width, 32, "Auto-Interval: ", 0, 1, Int.min.cgFloat, Int.max.cgFloat, 0, 100, 200, self))
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
        activeCheckBoxButton!.setChecked(repoItem.active)
        messageCheckBoxButton!.setChecked(repoItem.autoCommitMessage)
        /*LeverSpinner*/
        autoSyncIntervalLeverSpinner!.setValue(repoItem.interval.cgFloat)
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
                attrib[RepoItemType.title] = (event as! TextFieldEvent).stringValue
            case event.assert(Event.update,immediate:localPathTextInput):
                attrib[RepoItemType.] = (event as! TextFieldEvent).stringValue
            case event.assert(Event.update,immediate:remotePathTextInput):
                attrib["remote-path"] = (event as! TextFieldEvent).stringValue
            case event.assert(Event.update,immediate:remotePathTextInput):
                attrib["branch"] = (event as! TextFieldEvent).stringValue
            case event.assert(CheckEvent.check,immediate:uploadCheckBoxButton):
                attrib["broadcast"] = String((event as! CheckEvent).isChecked)
            case event.assert(CheckEvent.check,immediate:downloadCheckBoxButton):
                attrib["subscribe"] = String((event as! CheckEvent).isChecked)
            case event.assert(CheckEvent.check,immediate:messageCheckBoxButton):
                attrib["auto-sync"] = String((event as! CheckEvent).isChecked)
            case event.assert(SpinnerEvent.change, autoSyncIntervalLeverSpinner):
                attrib["interval"] = (event as! SpinnerEvent).value.string
            default:
                break;
        }
        node.setAttributeAt(i, attrib)
    }
}
