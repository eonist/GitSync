import Foundation
@testable import Utils

class AsyncTest2 {
    init(){
        var outerArr = [1,2,3]
        var innerArr = ["a","b"]
        /*Indecies*/
        var index = [[0],[0]]
        /*Completion handlers resides on the main thread*/
        func onInnerComplete(_ i_idx:Int, _ e_idx:Int){
            Swift.print("🍌 onInnerComplete i: \(i_idx) e: \(e_idx) 🍌")
            index += 1/*increment counter*/
            if(innerIdx == innerArr.count){
                innerIdx = 0//reset
                onOuterComplete(i_idx,e_idx)
            }
        }
        func onOuterComplete(_ i_idx:Int, _ e_idx:Int){
            Swift.print("🍏 onOuterComplete i: \(i_idx) e: \(e_idx) 🍏")
            outerIdx += 1
            if(outerIdx == outerArr.count){
                allOuterCompleted()
            }
        }
        func allOuterCompleted(){
            Swift.print("🏁 allOuterTasksCompleted: 🏁")
        }
        /*The goal here is to fire of all sleep tasks in one swoop on a bg thread, 6 sleep tasks at once. not one after the other*/
        for i in outerArr.indices{
            bg.async {/*do 3 things at the same time*/
                Swift.print("🚄 ---outer async started i: \(i)---")
                for e in innerArr.indices{
                    bg.async{/*do 2 things at the same time*/
                        Swift.print("===🚗 inner async started e: \(e)===")
                        sleep(IntParser.random(1, 6).uint32)/*simulates task that takes between 1 and 6 secs*/
                        main.async{/*we must jump back on main thread, because we want to manipulate a variable that resids on the main thread*/
                            onInnerComplete(i,e)
                        }
                    }
                }
            }
        }
    }
}
