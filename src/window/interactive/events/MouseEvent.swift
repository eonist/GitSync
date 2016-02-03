import Cocoa

//class MouseEventType{
    /*static var over:String = "mouseOver"*/
    /*static var out:String = "mouseOut"*/
    /*static var move:String = "mouseMove"*/
    /*static var down:String = "mouseDown"*/
    /*static var up:String = "mouseUp"*/
    /*static var enter:String = "mouseEnter"*/
    /*static var exit:String = "mouseExit"*/
//}
/**
 * TODO: implement the immidiate when its needed. 
 * NOTE: origin could in the future be a protocol IInteractiveElement for instance or IInteractive or IInteractiveView
 */
class MouseEvent{
    weak var event:NSEvent?
    /*var pos:CGPoint*/
    var origin:NSView?//origin sender of event
    /*var immidiate:Any?*///prev sender of event
    init(_ event:NSEvent/*_ type:String, *//*_ pos:CGPoint, */, _ origin:NSView? = nil/*, immidiate:Any? = nil*/){
        /*self.pos = pos*/
        self.event = event
        self.origin = origin
        /*self.immidiate = immidiate*/
    }
}