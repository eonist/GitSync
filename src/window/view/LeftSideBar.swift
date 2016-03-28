import Foundation

class LeftSideBar:Element{
    static let w:CGFloat = 200
    let buttonTitles = ["activity","repos","stats","settings"]/*"incoming","outgoing",*/
    override func resolveSkin() {
        //Swift.print("LeftSideBar.resolveSkin()")
        StyleManager.addStylesByURL("~/Desktop/css/gitsync/leftsidebar.css")
        super.resolveSkin()
        createButtons()
    }
    func createButtons(){
        let buttonSection = self.addSubView(Section(LeftSideBar.w,200,self,"buttonSection"))
        var buttons:Array<ISelectable> = []
        for buttonTitle in buttonTitles{
            let radioButton:RadioButton = buttonSection.addSubView(RadioButton(80,20,buttonTitle,false,buttonSection))
            buttons.append(radioButton)
            //buttons.append(buttonSection.addSubView(SelectButton(20,20,false,buttonSection,buttonTitle)))
        }
        let selectGroup = SelectGroup(buttons,buttons[0])
        buttons[0].setSelected(true)
        func onSelect(event:Event){
            //do something here
        }
        selectGroup.event = onSelect
    }
}