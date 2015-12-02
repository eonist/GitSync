import Foundation

class TestSelectGroup :View{
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        createContent()
    }
    func createContent(){
        
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}

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
