import Foundation
@testable import Utils
@testable import Element

class LeftSideBar:Element{
    override func resolveSkin() {
        var css:String = ""
        css += "#leftBar{fill:orange;fill-alpha:0;width:80px;height:100%;float:left;padding-top:26px;}"
        css += "#buttonSection {"
        css +=     "width:100%;"
        css +=     "height:100%;"
        css +=     "padding-top:16px;"
        css +=     "padding-left:28px;"
        css += "}"
        css += "#buttonSection SelectButton{"
        css +=     "fill:green;"
        css +=     "fill-alpha:0.3;"
        css +=     "width:24;"
        css +=     "height:24;"
        css +=     "float:left;"
        css +=     "clear:left;"
        css +=     "margin-bottom:12px;"
        css += "}"
        css += "#buttonSection SelectButton:selected{"
        css +=      "fill-alpha:0.6;"
        css += "}"
        StyleManager.addStyle(css)
        super.resolveSkin()
        createButtons()
    }
    func createButtons(){
        let buttonSection = self.addSubView(Section(NaN,NaN,self,"buttonSection"))
        let buttonTitles = ["commits","repos","settings"]
        var buttons:[ISelectable] = []
        for buttonTitle in buttonTitles{
            buttons.append(buttonSection.addSubView(SelectButton(20,20,true,buttonSection,buttonTitle)))
        }
        let selectGroup = SelectGroup(buttons,buttons[0]);
        func onSelect(event:Event){
            //do something here
        }
        selectGroup.event = onSelect
    }
}
