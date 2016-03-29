import Foundation

class ActivityTopBar:Element{
    override func resolveSkin() {
        StyleManager.addStyle("ActivityTopBar{float:left;clear:left;corner-radius:0px 4px 0px 0px;margin-bottom:12px;}")
        super.resolveSkin()
    }
}
