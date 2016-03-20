import Foundation

class LeftSideBar:Element{
    static let w:CGFloat = 75
    let buttonTitles = ["inbox","home","pics","camera","game","view"]//["activity","incoming","outgoing","repos","stats","settings"]
    override func resolveSkin() {
        Swift.print("LeftSideBar.resolveSkin()")
        StyleManager.addStylesByURL("~/Desktop/css/leftsidebar.css")
        super.resolveSkin()
    }
    func createButtons(){
        let buttonSection = self.addSubView(Section(LeftSideBar.w,200,self,"buttonSection"))
        var buttons:Array<ISelectable> = []
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