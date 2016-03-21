import Foundation

class RepoDetailView:Element{
    var nameTextInput:TextInput?
    var localPathTextInput:TextInput?
    var remotePathTextInput:TextInput?
    override func resolveSkin() {
        super.resolveSkin()
        
        StyleManager.addStyle("RepoDetailView TextInput{}")
        
        let repoData = RepoData.sharedInstance
        let repoItem = repoData.dp!.getItemAt(0)!
        
        Swift.print()
        //Name: (TextInput)
        nameTextInput = addSubView(TextInput(width, 32, "Name: ", repoItem["title"]!, self))
        //Local-path: (TextInput)
        localPathTextInput = addSubView(TextInput(width, 32, "Local-path: ", repoItem["local-path"]!, self))
        //Remote-path: (TextInput)
        remotePathTextInput = addSubView(TextInput(width, 32, "Remote-path: ", repoItem["remote-path"]!, self))
        //Broadcast: (CheckBox Button)
        
        //SubScribe: (CheckBox Button)
        //Auto-sync: (CheckBox Button)
        //Auto-sync-Interval: (LeverSlider)
        
    }
}
