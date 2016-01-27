import Cocoa

/**
 * TODO: Hook up the onWindowResize method
 */
class CustomView:WindowView{
    var section:Section?
    /**
     * Add content here
     */
    override func resolveSkin() {
        super.resolveSkin()
        
        //add close button, min, max
        //add event listeners to these buttons
        
        Swift.print("CustomView.resolveSkin()")
        
        //remember the contentview is sort of the container to hold items. might need to add things to this instance
        
        
        
        
        //let button = Button(20,20)
        //section.addSubview(button)
        
        var css:String = ""
        css += "Section#titleBar{float:left;clear:none;padding-top:4px;padding-left:8px;}"
        css += "Button{width:12px,12px;height:12px,12px;float:left;clear:none;margin-right:8px;margin-top:0px;padding-left:0px;padding-top:0px;}"//adding padding here shouldnt be necessary
        css += "Button:over{fill:~/Desktop/icons/title_bar/hover.svg none;}"
        css += "Button#close{fill:~/Desktop/icons/title_bar/close.svg none;}"
        css += "Button#minimize{fill:~/Desktop/icons/title_bar/min.svg none;}"
        css += "Button#maximize{fill:~/Desktop/icons/title_bar/max.svg none;}"
        StyleManager.addStyle(css)
        
        section = Section(frame.width,24,"titleBar")
        self.addSubview(section!)
        
        let closeButton = Button(12,12,section!,"close")/*<--the w and h should be NaN, test if it supports this*/
        section!.addSubview(closeButton)
        let minimizeButton = Button(12,12,section!,"minimize")
        section!.addSubview(minimizeButton)
        let maximizeButton = Button(12,12,section!,"maximize")
        section!.addSubview(maximizeButton)
        
        /*Event listeners:*/
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onCloseButtonReleaseInside:", name: ButtonEvent.releaseInside, object: closeButton)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMinimizeButtonReleaseInside:", name: ButtonEvent.releaseInside, object: minimizeButton)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onMaximizeButtonReleaseInside:", name: ButtonEvent.releaseInside, object: maximizeButton)
        
    }
    /**
     *
     */
    func setSize(size:CGSize){
        //Swift.print("CustomView.setSize() size: " + "\(size)")
        self.skin!.setSize(size.width, size.height)
        section!.setSize(size.width, section!.height)
    }
    /**
     *
     */
    func onCloseButtonReleaseInside(sender: AnyObject) {
        //Close window here
        //self.window?.close()//this closes the window
        NSApp.terminate(self)//quits the app
    }
    /**
     *
     */
    func onMinimizeButtonReleaseInside(sender: AnyObject){
        //minimize the window here
        
        //NSApp.miniaturizeAll(self)//minimizes all windows in the app
        self.window?.miniaturize(self)
    }
    /**
     * TODO: Add support for fullscreen mode aswell: window.setFrame(NSScreen.mainScreen()!.visibleFrame, display: true, animate: true)
     * TODO: add support for zooming back to normal size
     */
    func onMaximizeButtonReleaseInside(sender: AnyObject){
        //maximize the window here
        self.window?.zoom(self)
        
    }
    
}

