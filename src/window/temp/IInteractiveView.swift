import Foundation

protocol IInteractiveView {
    func mouseMoved(event:MouseEvent)
    func mouseOver(event:MouseEvent)
    func mouseOut(event:MouseEvent)
    func mouseDown(event:MouseEvent)
    func mouseUpInside(event: MouseEvent)
    func mouseUpOutside(event: MouseEvent)
    
}
