import Foundation

class LeftSideBar:Element{
    static let w:CGFloat = 75
    override func resolveSkin() {
        super.resolveSkin()
    }
    func createButtons(){
        let buttonSection = self.addSubView(Section(w,200,self,"buttonSection"))
        let buttonTitles = ["activity","incoming","outgoing","repos","stats","view"]
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