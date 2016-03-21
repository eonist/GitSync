import Foundation

class RepoDetailView:Element{
    var nameTextInput:TextInput?
    var localPathTextInput:TextInput?
    var remotePathTextInput:TextInput?
    override func resolveSkin() {
        super.resolveSkin()
        //Name: (TextInput)
        nameTextInput = addSubView(TextInput(width, 32, "Name: ", "Test A", self))
        //Local-path: (TextInput)
        localPathTextInput = addSubView(TextInput(width, 32, "Local-path: ", "/Desktop/", self))
        //Remote-path: (TextInput)
        remotePathTextInput = addSubView(TextInput(width, 32, "Remote-path: ", "github.com", self))
        //Broadcast: (CheckBox Button)
        remotePathTextInput = addSubView(TextInput(width, 32, "Remote-path: ", "github.com", self))
        //SubScribe: (CheckBox Button)
        //Auto-sync: (CheckBox Button)
        //Auto-sync-Interval: (LeverSlider)
        
    }
}
