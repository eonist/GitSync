import Foundation

class LeftSideBar:Element{
    static let w:CGFloat = 75
    override func resolveSkin() {
        super.resolveSkin()
    }
    func createButtons(){
        let buttonSection = self.addSubView(Section(75,200,self,"buttonSection"))
        let buttonTitles = ["inbox","home","pics","camera","game","view"]
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