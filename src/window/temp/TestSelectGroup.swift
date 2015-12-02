import Foundation

class TestSelectGroup :FlippedView{
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        createContent()
    }
    func createContent(){
        let css:String = "Button{fill:red;}Button:over{fill:yellow;}Button:down{fill:green;}"//
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        StyleManager.addStyle(styleCollection.styles)
        let btn1 = Button(200,40)
        self.addSubview(btn1)
        
        /*
        let btn2 = SelectButton(200,40)
        btn2.setPosition(CGPoint(0,60))
        self.addSubview(btn2)
        */
        
        /* 
        let selectGroup = SelectGroup([btn1,btn2])
        NSNotificationCenter.defaultCenter().addObserver(selectGroup, selector: "onSelect:", name: SelectGroupEvent.select, object: nil)
        func onSelect(sender: AnyObject) {
        Swift.print("TestSelectGroup.onSelect: " + String((sender as! NSNotification).object))/* as ISelectable).isSelected*/
        }
        */
    }

    

    /*
     * let radioButtonGroup = RadioButtonGroup([rb1,rb2, rb3]);
     * NSNotificationCenter.defaultCenter().addObserver(radioButtonGroup, selector: "onSelect:", name: SelectGroupEvent.select, object: radioButtonGroup)
     * func onSelect(sender: AnyObject) { Swift.print("Event: " + ((sender as! NSNotification).object as ISelectable).isSelected}
     */
    
    
    //create a view
    //make it work
    //add 2 nice buttons
    //try select group
}
