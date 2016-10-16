import Foundation

class RepoDetailView:Element {
    var topBar:RepoItemTopBar?
    var nameTextInput:TextInput?
    var localPathTextInput:TextInput?
    var remotePathTextInput:TextInput?
    var broadCastCheckBoxButton:CheckBoxButton?
    var subscribeCheckBoxButton:CheckBoxButton?
    var autoSyncCheckBoxButton:CheckBoxButton?
    var autoSyncIntervalLeverSpinner:LeverSpinner?
    override func resolveSkin() {
        super.resolveSkin()
        topBar = addSubView(RepoItemTopBar(width-24,36,self))
        nameTextInput = addSubView(TextInput(width, 32, "Name: ", "", self))
        localPathTextInput = addSubView(TextInput(width, 32, "Local-path: ", "", self))
        remotePathTextInput = addSubView(TextInput(width, 32, "Remote-path: ", "", self))
        broadCastCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Broadcast:", false, self))
        subscribeCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Subscribe:", false, self))
        //if auto sync is off then a manual commit popup dialog will appear (with pre-populated text)
        autoSyncCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Auto-sync:", false, self))
        //autoSyncIntervall needs to be a time setter: Day,Hour,Min,Seconds
        //0 means do not sync on an interval
        autoSyncIntervalLeverSpinner = addSubView(LeverSpinner(width, 32, "Auto-Interval: ", 0, 1, Int.min.cgFloat, Int.max.cgFloat, 0, 100, 200, self))
    }
    /**
     *
     */
    func setRepoData(repoData:Dictionary<String,String>){
        nameTextInput!.inputTextArea!.setTextValue(repoData["title"]!)
        localPathTextInput!.inputTextArea!.setTextValue(repoData["local-path"]!)
        remotePathTextInput!.inputTextArea!.setTextValue(repoData["remote-path"]!)
        broadCastCheckBoxButton!.setChecked(repoData["broadcast"]!.bool)
        subscribeCheckBoxButton!.setChecked(repoData["subscribe"]!.bool)
        autoSyncCheckBoxButton!.setChecked(repoData["auto-sync"]!.bool)
        autoSyncIntervalLeverSpinner!.setValue(repoData["interval"]!.cgFloat)
    }
}
class RepoItemTopBar:Element{
    var backButton:Button?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        backButton = addSubView(Button(16,16,self))
    }
}
