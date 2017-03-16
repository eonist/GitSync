import Cocoa
@testable import Element
@testable import Utils
protocol Scrollable2 {
    
}

extension ContainerView:Scrollable2{
    override open func scrollWheel(with event: NSEvent) {
        Swift.print("scrollWheel")
        /*switch event.phase{
         case NSEventPhase.changed:onScrollWheelChange(event)/*Fires everytime there is direct scrollWheel gesture movment and momentum, the momentum fades.*/
         case NSEventPhase.mayBegin:onScrollWheelEnter()/*Can be used to detect if two fingers are touching the trackpad*/
         case NSEventPhase.began:onScrollWheelEnter()/*The mayBegin phase doesnt fire if you begin the scrollWheel gesture very quickly*/
         case NSEventPhase.ended:onScrollWheelExit();//Swift.print("ended")/*if you release your touch-gesture and the momentum of the gesture has stopped.*/
         case NSEventPhase.cancelled:onScrollWheelExit();//Swift.print("cancelled")/*this trigers if the scrollWhell gestures goes off the trackpad etc*/
         //case NSEventPhase(rawValue:0):onInDirectScrollWheelChange(event);/*Swift.print("none");*/break;//swift 3 update, was -> NSEventPhase.none
         default:break;
         }
         super.scrollWheel(with: event)*/
    }
}
