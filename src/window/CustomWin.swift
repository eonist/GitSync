import Foundation

class CustomWin:Window{
    override func resolveSkin() {
        self.contentView = CustomView(frame.width,frame.height)/*Sets the mainview of the window*/
    }
}
 /*
 * TODO: You should extend the window not the view
 */
class CustomView:WindowView{
    //override var allowsVibrancy:Bool {return true}
    /**
     * Add content here
     */
    override func resolveSkin() {
        super.resolveSkin()
        
        
        
        //make the section also have round corners but only the top corners
        //add close button, min, max
        //add event listeners to these buttons
        
        Swift.print("CustomView.resolveSkin()")
        
        //let section = Section(120,40)
        //addSubview(section)
        //let button = Button(120,40)
        //addSubview(button)
    }
}
