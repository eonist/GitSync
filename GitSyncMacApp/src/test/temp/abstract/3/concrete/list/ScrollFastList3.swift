import Foundation

class ScrollFastList3:FastList3, ScrollableFastListable3{
    //continue here: make ScrollFastListable3, which overrides onChange. 
        //setProgress
}
protocol ScrollableFastListable3:FastListable3,Scrollable3{}
extension ScrollableFastListable3{
    func onScrollWheelChange(_ event: NSEvent) {
        
    }
}
