import Foundation

class RepoItemTopBar:Element{
    var backButton:TextButton?
    var removeButton:TextButton?
    override func resolveSkin() {
        StyleManager.addStyle("RepoItemTopBar{float:left;clear:left;corner-radius:0px 4px 0px 0px;margin-bottom:12px;}")
        super.resolveSkin()
        //add buttons here
        StyleManager.addStyle("RepoDetailView TextButton{width:50px;}")
        backButton = addSubView(TextButton("Back",32,24,self))
        
        StyleManager.addStyle("RepoDetailView TextButton#remove{width:60px;float:right;clear:none;}")
        removeButton = addSubView(TextButton("Remove",32,24,self,"remove"))
        
        /*
        StyleManager.addStyle("RepoItemTopBar Button#remove{float:right;clear:none;line:none;corner-radius:0px;line-thickness:0px;}")
        StyleManager.addStyle("RepoItemTopBar Button#remove{fill:white,~/Desktop/gitsync/assets/svg/remove.svg grey8;}")
        StyleManager.addStyle("RepoItemTopBar Button#remove{width:24px,16px;height:24px,16px;margin:0px,4px;}")
        
        
        removeButton = addSubView(Button(24,24,self,"remove"))
        */
        
    }
}