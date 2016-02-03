import Foundation

class MouseEventType{
    static var move:String = "mouseMove"
    static var down:String = "mouseDown"
    static var up:String = "mouseUp"
    static var enter:String = "mouseEnter"
    static var exit:String = "mouseExit"
}
/**
 * TODO: implement the immidiate when its needed. 
 */
class MouseEvent:Event{
    var pos:CGPoint
    var origin:Any?//origin sender of event
    /*var immidiate:Any?*///prev sender of event
    init(_ type:String, pos:CGPoint, origin:Any? = nil/*, immidiate:Any? = nil*/){
        self.pos = pos
        self.origin = origin
        /*self.immidiate = immidiate*/
        super.init(type)
    }
}