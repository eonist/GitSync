import Foundation

class LeftSideBar:Element{
    static let w:CGFloat = 75
    override func resolveSkin() {
        StyleManager.addStylesByURL("~/Desktop/css/stash.css")
        super.resolveSkin()
        //background = addSubView(Element(width,height,self,"background")) as? IElement
    }
    /**
     *
     */
    func createButtons(){
        let buttonSection = self.addSubView(Section(75,200,self,"buttonSection")) as! Section
        //buttonSection.addSubView(Button(50,50,buttonSection,"avatar")) as! Button
        let btn1 = buttonSection.addSubView(SelectButton(20,20,true,buttonSection,"inbox")) as! SelectButton
        let btn2 = buttonSection.addSubView(SelectButton(20,20,false,buttonSection,"home")) as! SelectButton
        let btn3 = buttonSection.addSubView(SelectButton(20,20,false,buttonSection,"pics")) as! SelectButton
        let btn4 = buttonSection.addSubView(SelectButton(20,20,false,buttonSection,"camera")) as! SelectButton
        let btn5 = buttonSection.addSubView(SelectButton(20,20,false,buttonSection,"game")) as! SelectButton
        let btn6 = buttonSection.addSubView(SelectButton(20,20,false,buttonSection,"view")) as! SelectButton
        
        let selectGroup = SelectGroup([btn1,btn2,btn3,btn4,btn5,btn6],btn1);
        func onSelect(event:Event){
            //do something here
        }
        selectGroup.event = onSelect
    }
}