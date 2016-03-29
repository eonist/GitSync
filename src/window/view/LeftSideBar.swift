import Foundation

class LeftSideBar:Element{
    static let w:CGFloat = 200
    static let actvity:String = "activity"
    static let repos:String = "repos"
    static let stats:String = "stats"
    static let settings:String = "settings"
    static let buttonTitles = [LeftSideBar.actvity,LeftSideBar.repos,LeftSideBar.stats,LeftSideBar.settings]/*"incoming","outgoing",*/
    override func resolveSkin() {
        //Swift.print("LeftSideBar.resolveSkin()")
        StyleManager.addStylesByURL("~/Desktop/css/gitsync/leftsidebar.css")
        super.resolveSkin()
        createButtons()
    }
    func createButtons(){
        let buttonSection = self.addSubView(Section(LeftSideBar.w,200,self,"buttonSection"))
        var buttons:Array<ISelectable> = []
        for buttonTitle in LeftSideBar.buttonTitles{
            let selectTextButton:SelectTextButton = buttonSection.addSubView(SelectTextButton(80,20,buttonTitle.capitalizedString,false,buttonSection,buttonTitle))
            buttons.append(selectTextButton)
            //buttons.append(buttonSection.addSubView(SelectButton(20,20,false,buttonSection,buttonTitle)))
        }
        let selectGroup = SelectGroup(buttons,buttons[0])
        buttons[0].setSelected(true)
        func onSelect(event:Event){
            //do something here
            let buttonId:String = ((event as! SelectGroupEvent).selected as! SelectTextButton).id!
            Swift.print("LeftSideBar.onSelect() buttonId: " + "\(buttonId)")
            Navigation.sharedInstance.setView(buttonId)
        }
        selectGroup.event = onSelect
    }
}