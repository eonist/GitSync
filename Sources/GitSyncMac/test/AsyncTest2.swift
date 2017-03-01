import Foundation
@testable import Utils

class AsyncTest2 {
    init(){
        var outerArr = ["a","b","c"]
        var innerAtt = [0,1]
        var outerIdx:Int = 0
        var innerIdx:Int = 0
        
        func allOuterTasksCompleted(){
            Swift.print("🏁 allOuterTasksCompleted: 🏁")
        }
        func onOuterComplete(_ i_idx:Int, _ e_idx:Int){
            Swift.print("🍏 onOuterComplete i: \(i_idx) e: \(e_idx) 🍏")
            outerIdx += 1
            Swift.print("outerIdx: " + "\(outerIdx)")
            if(outerIdx == 3){
                allOuterTasksCompleted()
            }
        }
        func onInnerComplete(_ i_idx:Int, _ e_idx:Int){
            Swift.print("🍌 onInnerComplete i: \(i_idx) e: \(e_idx) 🍌")
            main.async{/*we must jump back on main thread, because we want to manipulate a variable that resids on the main thread*/
                innerIdx += 1/*increment counter*/
                if(innerIdx == 2){
                    innerIdx = 0//reset
                    onOuterComplete(i_idx,e_idx)
                }
            }
        }
        for i in 0..<3{
            bg.async {/*do 3 things at the same time*/
                Swift.print("---outer async started i: \(i)---")
                for e in 0..<2{
                    Swift.print("===inner async started e: \(e)===")
                    bg.async{/*do 2 things at the same time*/
                        sleep(IntParser.random(1, 6).uint32)/*simulates task that takes between 1 and 6 secs*/
                        onInnerComplete(i,e)
                    }
                }
            }
        }
    }
}
