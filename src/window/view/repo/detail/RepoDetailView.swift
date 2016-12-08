import Foundation

class RepoDetailView:Element {
    var topBar:RepoItemTopBar?
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
        topBar = addSubView(RepoItemTopBar(width-24,NaN,self))
        nameTextInput = addSubView(TextInput(width, 32, "Name: ", "", self))
        localPathTextInput = addSubView(TextInput(width, 32, "Local-path: ", "", self))
        remotePathTextInput = addSubView(TextInput(width, 32, "Remote-path: ", "", self))
        branchTextInput = addSubView(TextInput(width, 32, "Branch: ", "", self))//branch-text-input: master is default, set to dev for instance
        subscribeCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Upload:", false, self))
        broadCastCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Download:", false, self))//to disable an item uncheck broadcast and subscribe
        autoMessageCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Auto-message:", false, self))//if auto sync is off then a manual commit popup dialog will appear (with pre-populated text)
        autoSyncCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Auto-sync:", false, self))
    }
    /**
     * Populates the UI elements with data from the dp item
     */
    func setRepoData(repoData:Dictionary<String,String>){
        nameTextInput!.inputTextArea!.setTextValue(repoData["title"]!)
        localPathTextInput!.inputTextArea!.setTextValue(repoData["local-path"]!)
        remotePathTextInput!.inputTextArea!.setTextValue(repoData["remote-path"]!)
        branchTextInput!.inputTextArea!.setTextValue(repoData["branch"]!)
        broadCastCheckBoxButton!.setChecked(repoData["broadcast"]!.bool)
        subscribeCheckBoxButton!.setChecked(repoData["subscribe"]!.bool)
        autoMessageCheckBoxButton!.setChecked(repoData["auto-sync"]!.bool)
        //autoSyncIntervalLeverSpinner!.setValue(repoData["interval"]!.cgFloat)
    }
    /**
     * Modifies the dataProvider item on UI change
     */
    override func onEvent(event:Event) {
        let i:Int = RepoView.selectedListItemIndex
        let dp:DataProvider = RepoView.dp!
        switch true{
            case event.assert(Event.update,immediate:nameTextInput):
                dp.setValue(i, "title", (event as! TextFieldEvent).stringValue)
            case event.assert(Event.update,immediate:localPathTextInput):
                dp.setValue(i, "local-path", (event as! TextFieldEvent).stringValue)
            case event.assert(Event.update,immediate:remotePathTextInput):
                dp.setValue(i, "remote-path", (event as! TextFieldEvent).stringValue)
            case event.assert(Event.update,immediate:remotePathTextInput):
                dp.setValue(i, "branch", (event as! TextFieldEvent).stringValue)
            case event.assert(CheckEvent.check,immediate:broadCastCheckBoxButton):
                dp.setValue(i, "broadcast", String((event as! CheckEvent).isChecked))
            case event.assert(CheckEvent.check,immediate:subscribeCheckBoxButton):
                dp.setValue(i, "subscribe", String((event as! CheckEvent).isChecked))
            case event.assert(CheckEvent.check,immediate:autoMessageCheckBoxButton):
                dp.setValue(i, "auto-sync", String((event as! CheckEvent).isChecked))
            //case event.assert(SpinnerEvent.change, autoSyncIntervalLeverSpinner):
                //dp.setValue(i, "interval", (event as! SpinnerEvent).value.string)
            default:
                break;
        }
    }
}
class RepoItemTopBar:Element{
    var backButton:Button?
    var removeButton:Button?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        backButton = addSubView(Button(NaN,NaN,self,"back"))
        removeButton = addSubView(Button(NaN,NaN,self,"remove"))
    }
    func onBackButtonClick(){
        Swift.print("onBackButtonClick()")
        Sounds.disable?.play()
        Navigation.setView(MenuView.repos)
    }
    func onRemoveButtonClick(){
        Swift.print("onRemoveButtonClick")
        Sounds.delete?.play()
        RepoView.dp!.removeItemAt(RepoView.selectedListItemIndex)//remove from item from RepoView.list at the repoView.list.selectedIndex
        RepoView.selectedListItemIndex = -1//-1 means no item is selected
        Navigation.setView(MenuView.repos)
    }
    override func onEvent(event:Event) {
        if(event.assert(ButtonEvent.upInside, backButton)){onBackButtonClick()}
        else if(event.assert(ButtonEvent.upInside, removeButton)){onRemoveButtonClick()}
    }
}
