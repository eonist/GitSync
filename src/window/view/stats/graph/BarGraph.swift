import Cocoa

class BarGraph:NSView {
    //Continue here:
        //Extract the gesture out of CommitGraph
        //override createGraph
        //create dummy methods with sudo code that calcs the bars and draws them etc
        //test it
        //create the touch point visualisations
    /**
     *
     */
    func helloWorld(){
        let style = Style("Button")
        style.addStyleProperty(StyleProperty("fill",NSColor.blue))
        let btn = addSubView(Button(96,24))
        
        func onClick(event:Event){
            Swift.print("Hello world")
        }
        btn.event = onClick
    }
}
