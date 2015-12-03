import Foundation

class TestSelectGroup :FlippedView{
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        createContent()
    }
    func createContent(){
        let css:String = "SelectButton{fill:red;}SelectButton:over{fill:yellow;}SelectButton:down{fill:green;}SelectButton:selected{fill:blue;}"
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        StyleManager.addStyle(styleCollection.styles)
        let btn1 = SelectButton(200,40)
        //btn1.setPosition(CGPoint(0,0))
        self.addSubview(btn1)
        
        
        /*
        let notificationTest = NotificationTest()
        addSubview(notificationTest)
        notificationTest.test(btn1)
        */
        
        let btn2 = SelectButton(200,40)
        btn2.setPosition(CGPoint(0,60))
        self.addSubview(btn2)
        /**/
        
        let btn3 = SelectButton(200,40)
        btn3.setPosition(CGPoint(0,120))
        self.addSubview(btn3)
        
        
        let selectGroup = SelectGroup([btn1,btn2,btn3])
        addSubview(selectGroup)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onSelect:", name: SelectGroupEvent.select, object: selectGroup)
        

    }

    func onSelect(notification: NSNotification) {
        Swift.print("TestSelectGroup.onSelect()")
        Swift.print("TestSelectGroup.onSelect: " + String(notification.object))/* as ISelectable).isSelected*/
        
        //selected should be blue (see old css code)
        //deselect should work
        //try 3 buttons
        
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
