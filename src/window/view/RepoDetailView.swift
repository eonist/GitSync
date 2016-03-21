import Foundation

class RepoDetailView:Element{
    var backButton:TextButton?
    var nameTextInput:TextInput?
    var localPathTextInput:TextInput?
    var remotePathTextInput:TextInput?
    var broadCastCheckBoxButton:CheckBoxButton?
    var subscribeCheckBoxButton:CheckBoxButton?
    var autoSyncCheckBoxButton:CheckBoxButton?
    var autoSyncIntervalLeverSpinner:LeverSpinner?
    override func resolveSkin() {
        StyleManager.addStyle("RepoDetailView{padding-top:8px;}")
        super.resolveSkin()
        
        StyleManager.addStyle("RepoDetailView TextInput Text{width:90px;}")
        StyleManager.addStyle("RepoDetailView TextInput TextArea{width:130px;}RepoDetailView TextInput TextArea Text{width:120px;}")
        //StyleManager.addStyle("RepoDetailView TextInput TextArea{drop-shadow:none;line-alpha:0;line-thickness:0px;}")
        StyleManager.addStyle("RepoDetailView CheckBoxButton{clear:left;}")
        StyleManager.addStyle("RepoDetailView CheckBoxButton CheckBox{float:right;}")
        StyleManager.addStyle("RepoDetailView CheckBoxButton{width:105px;height:24px;}")
        StyleManager.addStyle("RepoDetailView Spinner TextInput Text{width:90px;}")
        StyleManager.addStyle("RepoDetailView Spinner TextInput TextArea{width:60px;}")
        StyleManager.addStyle("RepoDetailView Spinner TextInput{width:150px;}")
        
        let repoData = RepoData.sharedInstance
        let repoItem = repoData.dp!.getItemAt(0)!
        
        //continue here: Add back button
        backButton = addSubView(TextButton("Back",32,24,self))
        nameTextInput = addSubView(TextInput(width, 32, "Name: ", repoItem["title"]!, self))
        localPathTextInput = addSubView(TextInput(width, 32, "Local-path: ", repoItem["local-path"]!, self))
        remotePathTextInput = addSubView(TextInput(width, 32, "Remote-path: ", repoItem["remote-path"]!, self))
        broadCastCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Broadcast:", repoItem["broadcast"]!.bool, self))
        subscribeCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Subscribe:", repoItem["subscribe"]!.bool, self))
        autoSyncCheckBoxButton = addSubView(CheckBoxButton(width, 32, "Auto-sync:", repoItem["auto-sync"]!.bool, self))
        autoSyncIntervalLeverSpinner = addSubView(LeverSpinner(width, 32, "Auto-Interval: ", repoItem["interval"]!.cgFloat, 1, Int.min.cgFloat, Int.max.cgFloat, 0, 100, 200, self))
    }
}