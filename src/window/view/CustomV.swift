import Cocoa

class TestView1:CustomView{
    var section:Section?
    var closeButton:Button?
    var minimizeButton:Button?
    var maximizeButton:Button?
    /**
     * Add content here
     */
    override func resolveSkin() {
        super.resolveSkin()
         createTitleBar()
    }
    /**
     * Adds close button, min, max
     */
    func createTitleBar(){
        //Swift.print("CustomView.createTitleBar()")
        StyleManager.addStylesByURL("~/Desktop/css/titleBar.css")
        section = self.addSubView(Section(frame.width,16,self,"titleBar")) as? Section
        closeButton = section!.addSubView(Button(0,0,section!,"close")) as? Button/*<--TODO: the w and h should be NaN, test if it supports this*/
        minimizeButton = section!.addSubView(Button(0,0,section!,"minimize")) as? Button
        maximizeButton = section!.addSubView(Button(0,0,section!,"maximize")) as? Button
    }
}
