import Foundation

class LeftSideBar:Element{
    static let w:CGFloat = 75
    override func resolveSkin() {
        super.resolveSkin()
    }
    func createButtons(){
        let buttonSection = self.addSubView(Section(75,200,self,"buttonSection")) as! Section
        let buttons = ["inbox","home","pics","camera","game","view"]
        let btn1 = buttonSection.addSubView(SelectButton(20,20,true,buttonSection,"")) as! SelectButton
        let btn2 = buttonSection.addSubView(SelectButton(20,20,false,buttonSection,"")) as! SelectButton
        let btn3 = buttonSection.addSubView(SelectButton(20,20,false,buttonSection,"")) as! SelectButton
        let btn4 = buttonSection.addSubView(SelectButton(20,20,false,buttonSection,"")) as! SelectButton
        let btn5 = buttonSection.addSubView(SelectButton(20,20,false,buttonSection,"")) as! SelectButton
        let btn6 = buttonSection.addSubView(SelectButton(20,20,false,buttonSection,"")) as! SelectButton
        
        let selectGroup = SelectGroup([btn1,btn2,btn3,btn4,btn5,btn6],btn1);
        func onSelect(event:Event){
            //do something here
        }
        selectGroup.event = onSelect
    }
}