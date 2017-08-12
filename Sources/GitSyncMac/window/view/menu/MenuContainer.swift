import Cocoa
@testable import Utils
@testable import Element

class MenuContainer:Element {
    static let buttonTitles:[Nav.ViewType.Main] = [.commit,.repo,.prefs]
    var selectGroup:SelectGroup?
    
    override func resolveSkin() {
//        Swift.print("MenuContainer.resolveSkin()")
        super.resolveSkin()//skin = SkinResolver.skin(self)
        createButtons()
    }
    func createButtons(){
        var buttons:[ISelectable] = MenuContainer.buttonTitles.map{ buttonTitle in
            return self.addSubView(SelectButton(20,20,false,self,buttonTitle.rawValue))
        }
        selectGroup = SelectGroup(buttons,buttons[0])
        func onSelect(event:Event){
            if event.type == SelectEvent.select {
                if let btn:SelectButton = event.origin as? SelectButton{
                      _ = btn.id
//                    Swift.print("btn.id: " + "\(String(describing: btn.id))")
                }
            }
        }
        selectGroup!.event = onSelectGroupChange
        //selectGroup.event = onSelect
    }
    func onSelectGroupChange(event:Event){
        if(event === (SelectGroupEvent.change,selectGroup!)){
            let buttonId:String = (selectGroup!.selected as! Element).id!
//            Swift.print("LeftBarMenu.onSelect() buttonId: " + "\(buttonId)")
            let type = Nav.ViewType.Main(rawValue:buttonId)!//<--nice!
            Nav.setView(.main(type))//👌
        }
    }
}
extension MenuContainer{
    /**
     * Selects the button based on Main view enum case 👌
     */
    func selectButton(_ view:Nav.ViewType){
        switch view {
        case .main(let viewType):
            selectGroup!.selectables.forEach{
                if ($0 as? Element)?.id == viewType.rawValue {
                    $0.setSelected(true)
                }
            }
        default:
            _ = ""//do nothing
        }
    }
}
