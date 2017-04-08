import Cocoa
@testable import Utils
@testable import Element
/**
 * NOTE: The reasoning behind having this menu is that when a skeptical user tries the app for the first time, the first thing they do is browse around. If the menu system is too clever they wont even do that. 
 */
class MenuView:Element{
    static let buttonTitles:[Views.Main] = [.commits,.repos,.stats,.prefs]
    var selectGroup:SelectGroup?
    override func resolveSkin() {
        Swift.print("MenuView.resolveSkin()")
        super.resolveSkin()//skin = SkinResolver.skin(self)
        createButtons()
        _ = self.addSubView(Element(NaN, NaN, self, "ruler"))
    }
    func createButtons(){
        let buttonSection = self.addSubView(Container(200,48,self,"buttonSection"))
        var buttons:[ISelectable] = []
        for buttonTitle in MenuView.buttonTitles{
            let btn:SelectButton = buttonSection.addSubView(SelectButton(20,20,false,buttonSection,buttonTitle.rawValue))//buttonTitle.capitalizedString
            buttons.append(btn)
        }
        selectGroup = SelectGroup(buttons,buttons[0])
        //buttons[0].setSelected(true)
        
        selectGroup!.event = onSelectGroupChange
    }
    func onSelectGroupChange(event:Event){
        if(event === (SelectGroupEvent.change,selectGroup!)){
            let buttonId:String = (selectGroup!.selected as! Element).id!
            Swift.print("MainMenu.onSelect() buttonId: " + "\(buttonId)")
            //Sounds.enable?.stop()//<--this sound may be played in fast succesion, so stop it and replay it
            //Sounds.enable?.play()
            let type:Views.Main = Views.Main(rawValue:buttonId)!//<--nice!
            Navigation.setView(Views.main(type))//👌
        }
    }
}
extension MenuView{
    /**
     * Selects the button based on Main view enum case 👌
     */
    func selectButton(_ view:Views){
        switch view {
            case .main(let viewType):
                selectGroup!.selectables.forEach{if(($0 as! Element).id == viewType.rawValue){$0.setSelected(true)}}
            default:
                _ = ""//do nothing
        }
    }
}
