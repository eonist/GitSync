import Foundation

class CustomWin:Window{
    override func resolveSkin() {
        self.contentView!.addSubview(CustomView(frame.width,frame.height))/*Sets the mainview of the window*/
    }
}
 /*
 * TODO: You should extend the window not the view
 */
class CustomView:WindowView{
    
    /**
     * Add content here
     */
    override func resolveSkin() {
        super.resolveSkin()
        
        
        
        //make the section also have round corners but only the top corners
        //add close button, min, max
        //add event listeners to these buttons
        
        Swift.print("CustomView.resolveSkin()")
        
        //remember the contentview is sort of the container to hold items. might need to add things to this instance
        
        
        let section = Section(120,40)
        addSubview(section)
        //let button = Button(120,40)
        //addSubview(button)
    }
}
