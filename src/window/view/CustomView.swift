import Cocoa

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
        
        //let button = Button(20,20)
        //section.addSubview(button)
        
        var css:String = "Button{width:12px,12px;height:12px,12px;margin-left:0px;margin-top:0px;}"
        css += "Button:over{fill:~/Desktop/icons/title_bar/hover.svg none;}"
        css += "Button#close{fill:~/Desktop/icons/title_bar/close.svg none;}"
        css += "Button#minimize{fill:~/Desktop/icons/title_bar/min.svg none;}"
        css += "Button#maximize{fill:~/Desktop/icons/title_bar/max.svg none;}"
        
        StyleManager.addStyle(css)
        let closeButton = Button(12,12,nil,"close")/*<--the w and h should be NaN, test if it supports this*/
        let minimizeButton = Button(12,12,nil,"minimize")
        let maximizeButton = Button(12,12,nil,"maximize")
        
        self.addSubview(closeButton)
        closeButton.setPosition(CGPoint(8,4))
        self.addSubview(minimizeButton)
        minimizeButton.setPosition(CGPoint(28,4))
        self.addSubview(maximizeButton)
        maximizeButton.setPosition(CGPoint(48,4))
        
        
    }
}

