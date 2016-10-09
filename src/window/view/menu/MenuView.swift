import Foundation

class MenuView:Element{
    static let commits:String = "commits"
    static let repos:String = "repos"
    static let stats:String = "stats"
    static let prefs:String = "prefs"
    static let buttonTitles = [MenuView.commits,MenuView.repos,MenuView.stats,MenuView.prefs]
    override func resolveSkin() {
        Swift.print("MenuView.resolveSkin()")
        super.resolveSkin()
        createButtons()
    }
    func createButtons(){
        let buttonSection = self.addSubView(Section(200,36,self,"buttonSection"))
        var buttons:Array<ISelectable> = []
        for buttonTitle in MenuView.buttonTitles{
            let selectTextButton:SelectTextButton = buttonSection.addSubView(SelectTextButton(60,20,buttonTitle.capitalizedString,false,buttonSection,buttonTitle))
            buttons.append(selectTextButton)
        }
        let selectGroup = SelectGroup(buttons,buttons[0])
        buttons[0].setSelected(true)
        func onSelectGroupChange(event:Event){
            if(){
                
            }
            let buttonId:String = (selectGroup.selected as! SelectTextButton).id!
            Swift.print("MainMenu.onSelect() buttonId: " + "\(buttonId)")
            //Navigation.sharedInstance.setView(buttonId)
        }
        selectGroup.event = onSelectGroupChange
    }
}
