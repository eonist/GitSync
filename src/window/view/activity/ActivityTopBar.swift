import Foundation

class ActivityTopBar:Element{
    override func resolveSkin() {
        StyleManager.addStyle("ActivityTopBar{float:left;clear:left;corner-radius:0px 4px 0px 0px;margin-bottom:12px;padding-left:10px;}")
        super.resolveSkin()
        StyleManager.addStyle("ActivityTopBar Container#searchBoxCard{float:left;clear:left;}")
        let container = addSubView(Container(120,120,self,"searchBoxCard"))
        let searchBox:TextArea = container.addSubView(TextArea(NaN, NaN, "Search", container))
        searchBox
    }
}