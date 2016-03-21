import Foundation

class TopBar:Element{
    var addButton:TextButton?
    
    override func resolveSkin() {
        StyleManager.addStyle("TopBar{float:left;clear:left;corner-radius:0px 4px 0px 0px;padding-left:10px;margin-bottom:12px;}")
        super.resolveSkin()
        
        StyleManager.addStyle("TopBar TextButton{width:50px;float:left;clear:none;}")
        addButton = addSubView(TextButton("Add",32,24,self))
        
        /*
        StyleManager.addStyle("TopBar Button#add{float:left;clear:none;line:none;corner-radius:0px;line-thickness:0px;}")//fill:green;
        StyleManager.addStyle("TopBar Button#add{fill:white,~/Desktop/gitsync/assets/svg/add.svg grey8;}")
        StyleManager.addStyle("TopBar Button#add{width:24px,16px;height:24px,16px;margin:0px,4px;}")
        
        
        addButton = addSubView(Button(24,24,self,"add"))
        */
        
        
        
    }
}