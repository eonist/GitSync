import Foundation

class TestView8 :CustomView {
    override func resolveSkin() {
        super.resolveSkin()
        StyleManager.addStylesByURL("~/Desktop/css/del.css")
        let blueBox = addSubView(Element(100,100,self,"blueBox"))
        blueBox.addSubView(Element(0,50,blueBox,"redBox"))
        
        //Continue here: I think the bug is that you cant have NaN values in the frame.
        //So store width and height in variables and set the frame to zero. Try it!
        
    }
}
