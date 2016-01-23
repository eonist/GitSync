import Foundation

class CustomWin:Window{
    override func resolveSkin() {
        self.contentView = WindowView(frame.width,frame.height)/*Sets the mainview of the window*/
    }
}
 /*
 * TODO: You should extend the window not the view
 */
class TestWinView:WindowView{
    /**
     * Add content here
     */
    override func resolveSkin() {
        super.resolveSkin()
        let section = Section(120,40)
        addSubview(section)
        //let button = Button(120,40)
        //addSubview(button)
    }
}
