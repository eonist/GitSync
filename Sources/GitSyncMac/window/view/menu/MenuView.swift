import Cocoa
@testable import Utils
@testable import Element
/**
 * NOTE: The reasoning behind having this menu is that when a skeptical user tries the app for the first time, the first thing they do is browse around. If the menu system is too clever they wont even do that. 
 */
class MenuView:Element{
    static let commits:String = "commits"
    static let repos:String = "repos"
    static let stats:String = "stats"
    static let prefs:String = "prefs"
    static let buttonTitles = [MenuView.commits,MenuView.repos,MenuView.stats,MenuView.prefs]
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
            let btn:SelectButton = buttonSection.addSubView(SelectButton(20,20,false,buttonSection,buttonTitle))//buttonTitle.capitalizedString
            buttons.append(btn)
        }
        selectGroup = SelectGroup(buttons,buttons[0])
        //buttons[0].setSelected(true)
        selectGroup!.selectables.forEach{if(($0 as! Element).id == Navigation.activeView){$0.setSelected(true)}}
        selectGroup!.event = onSelectGroupChange
    }
    func onSelectGroupChange(event:Event){
        if(event.assert(SelectGroupEvent.change, selectGroup)){
            let buttonId:String = (selectGroup!.selected as! Element).id!
            Swift.print("MainMenu.onSelect() buttonId: " + "\(buttonId)")
            Sounds.enable?.stop()//<--this sound may be played in fast succesion, so stop it and replay it
            Sounds.enable?.play()
            Navigation.setView(buttonId)
        }
    }
}
