import Cocoa
@testable import Utils
@testable import Element

class ScrollFastList3:FastList3, ScrollableFastListable3{
    //continue here: make ScrollFastListable3, which overrides onChange. 
        //setProgress
}
protocol ScrollableFastListable3:FastListable3,Scrollable3{}
