import Cocoa
@testable import Utils
@testable import Element

class MenuContainer:Element {
    override func resolveSkin() {
        Swift.print("MenuView.resolveSkin()")
        super.resolveSkin()//skin = SkinResolver.skin(self)
        createButtons()
        
    }
    
    func createButtons(){
        let buttonSection = self.addSubView(Section(NaN,NaN,self,"buttonSection"))
        let titles = [Views2.Main.commit.rawValue,Views2.Main.repo.rawValue,Views2.Main.prefs.rawValue]
        var buttons:[ISelectable] = titles.map{ buttonTitle in
            return buttonSection.addSubView(SelectButton(20,20,true,buttonSection,buttonTitle))
        }
        selectGroup = SelectGroup(buttons,buttons[0])
        func onSelect(event:Event){
            if event.type == SelectEvent.select {
                if let btn:SelectButton = event.origin as? SelectButton{
                    Swift.print("btn.id: " + "\(btn.id)")
                }
            }
        }
        selectGroup!.event = onSelectGroupChange
        //selectGroup.event = onSelect
    }
    
    
    func onSelectGroupChange(event:Event){
        if(event === (SelectGroupEvent.change,selectGroup!)){
            let buttonId:String = (selectGroup!.selected as! Element).id!
            Swift.print("LeftBarMenu.onSelect() buttonId: " + "\(buttonId)")
            let type:Views2.Main = Views2.Main(rawValue:buttonId)!//<--nice!
            Nav.setView(Views2.main(type))//👌
        }
    }
}
