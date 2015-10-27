import Foundation
import Cocoa

class Panel:Section {
    static var leftPadding = 12
    static var rightPadding = 12
    init() {
        let x:Int = Table.width+Panel.leftPadding
        let y:Int = Win.topPadding
        let width = Win.width-Table.width-Panel.leftPadding-Panel.rightPadding
        let height = Win.height-Win.topPadding-EditMenu.height
        //let rect:NSRect = NSRect(x:x, y: y, width: width,height:height)//view.bounds
        let style = Style(Fill(NSColor.orangeColor()),Stroke(5,NSColor.blueColor()))
        
        super.init(width, height,style)
        
        super.frame.origin.x = CGFloat(x)
        super.frame.origin.y = CGFloat(y)
        createContent()
    }
    /**
    * TODO: create the align methods, you need them!!!
    */
    func createContent(){
        //Name: text inputfield
        //let width:Int = 300//Int(self.frame.width) - Panel.leftPadding - Panel.rightPadding
        let nameTextInput = TextInput(300,36,"Name: ","")
        addSubview(nameTextInput)
        //Local Path: text input field and browse button
        let style = Style(Fill(ColorParser.nsColor("#FF0000")!))
        let localPathSection = Section(500,24,style)
        addSubview(localPathSection)
        
        let localPathTextInput = TextInput(350,36,"Local path: ","")
        localPathSection.addSubview(localPathTextInput)
        
        //browse button
        let browseButton = TextButton("Browse",100,24,Style.green)
        localPathSection.addSubview(browseButton)//Add button to view
        browseButton.frame.origin.x = localPathTextInput.frame.origin.x + localPathTextInput.frame.width +  12
        //browseButton.frame.origin.y = localPathTextInput.frame.origin.y
        
        
        //Remote path: text input field
        let remotePathTextInput = TextInput(300,36,"Remote path: ","")
        addSubview(remotePathTextInput)
        
        Align.vertically(self.subviews, Panel.leftPadding, 12, 12)
        
        //Subscribe: checkBoxButton
        //Broadcast: checkBoxButton
        //Active: checkBoxButton
        //Relay: checkBoxButton (early beta function for servers, always uses theirs update and forgoes the conflict resolution dialog)
        //keychain id:
    }
    required init?(coder: NSCoder) {//try to get rid of this
        fatalError("init(coder:) has not been implemented")
    }
    /*
    * This makes sure that the view draws from top left corner
    */
    override var flipped:Bool {
        get {
            return true
        }
    }
    /*
    * Disables clipping of the view
    */
    override var wantsDefaultClipping : Bool {
        return false
    }
}