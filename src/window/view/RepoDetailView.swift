import Foundation

class RepoDetailView:Element{
    override func resolveSkin() {
        super.resolveSkin()
        //Name: (TextInput)
        let textInput:TextInput = addSubView(TextInput(width, 32, "Name: ", "Test A", self))
        textInput
        //Local-path: (TextInput)
        //Remote-path: (TextInput)
        //Broadcast: (CheckBox Button)
        //SubScribe: (CheckBox Button)
        //Auto-sync: (CheckBox Button)
        //Auto-sync-Interval: (LeverSlider)
        
    }
}
