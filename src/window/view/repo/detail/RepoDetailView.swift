import Foundation

class RepoDetailView:Element {
    var topBar:RepoItemTopBar?
    var nameTextInput:TextInput?
    var localPathTextInput:TextInput?
    var remotePathTextInput:TextInput?
    var branchTextInput:TextInput?
    var broadCastCheckBoxButton:CheckBoxButton?
    var subscribeCheckBoxButton:CheckBoxButton?
    var autoSyncCheckBoxButton:CheckBoxButton?
    var autoSyncIntervalLeverSpinner:LeverSpinner?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        topBar = addSubView(RepoItemTopBar(width-24,36,self))
        nameTextInput = addSubView(TextInput(width, 32, "Name: ", "", self))
        localPathTextInput = addSubView(TextInput(width, 32, "Local-path: ", "", self))
        remotePathTextInput = addSubView(TextInput(width, 32, "Remote-path: ", "", self))
        branchTextInput = addSubView(TextInput(width, 32, "Branch: ", "", self))//branch-text-input: master is default, set to dev for instance
        subscribeCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Subscribe:", false, self))
        broadCastCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Broadcast:", false, self))//to disable an item uncheck broadcast and subscribe
        autoSyncCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Auto-message:", false, self))//if auto sync is off then a manual commit popup dialog will appear (with pre-populated text)
        autoSyncIntervalLeverSpinner = addSubView(LeverSpinner(width, 32, "Sync-Interval: ", 0, 1, Int.min.cgFloat, Int.max.cgFloat, 0, 100, 200, self))//autoSyncIntervall needs to be a time setter: Day,Hour,Min,Seconds,0 means do not sync on an interval
    }
    func setRepoData(repoData:Dictionary<String,String>){
        nameTextInput!.inputTextArea!.setTextValue(repoData["title"]!)
        localPathTextInput!.inputTextArea!.setTextValue(repoData["local-path"]!)
        remotePathTextInput!.inputTextArea!.setTextValue(repoData["remote-path"]!)
        branchTextInput!.inputTextArea!.setTextValue(repoData["branch"]!)
        broadCastCheckBoxButton!.setChecked(repoData["broadcast"]!.bool)
        subscribeCheckBoxButton!.setChecked(repoData["subscribe"]!.bool)
        autoSyncCheckBoxButton!.setChecked(repoData["auto-sync"]!.bool)
        autoSyncIntervalLeverSpinner!.setValue(repoData["interval"]!.cgFloat)
    }
    
}
class RepoItemTopBar:Element{
    var backButton:Button?
    var removeButton:Button?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        backButton = addSubView(Button(16,16,self))
        removeButton = addSubView(Button(NaN,NaN,self,"remove"))
    }
    func onBackButtonClick(){
        Swift.print("onBackButtonClick()")
        Navigation.setView(MenuView.repos)
    }
    func onRemoveButtonClick(){
        Swift.print("onRemoveButtonClick")
    }
    override func onEvent(event:Event) {
        if(event.assert(ButtonEvent.upInside, backButton)){onBackButtonClick()}
        else if(event.assert(ButtonEvent.upInside, removeButton)){onRemoveButtonClick()}
    }
}
