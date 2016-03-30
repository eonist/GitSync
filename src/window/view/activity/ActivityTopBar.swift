import Foundation

class ActivityTopBar:Element{
    override func resolveSkin() {
        StyleManager.addStyle("ActivityTopBar{fill:white;fill-alpha:1;float:left;clear:left;corner-radius:0px 4px 0px 0px;}")/*margin-bottom:12px;*/
        super.resolveSkin()
        StyleManager.addStyle("ActivityTopBar Container#searchBoxCard{float:left;clear:left;padding-top:16px;padding-left:10px;}")
        let container = addSubView(Container(120,120,self,"searchBoxCard"))
        
        let searchBox:TextArea = container.addSubView(TextArea(NaN, NaN, "Filter commits", container))
        searchBox
    }
}