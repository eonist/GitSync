import Foundation
@testable import Utils

//do 3 things async, 
//then in each 3 things do 4 things async but do something on mainthread when these 4 things are all finished

class ASyncTest {
    /**
     *
     */
    init(){
        var outerIdx:Int = 0

        func allOuterTasksCompleted(){
            Swift.print("🏁 allOuterTasksCompleted: 🏁")
        }
        func onOuterComplete(_ index:Int){
            Swift.print("all inner async tasks completed on outer async id: \(index)")
            outerIdx += 1
            Swift.print("outerIdx: " + "\(outerIdx)")
            if(outerIdx == 3){
                allOuterTasksCompleted()
            }
        }
        for i in 0..<3{
            bg.async {/*do 3 things at the same time*/
                Swift.print("---outer async started i: \(i)---")
                var innerIdx:Int = 0
                func onInnerComplete(_ index:Int){
                    Swift.print("inner async task completed e: \(index)")
                    innerIdx += 1/*increment counter*/
                    if(innerIdx == 2){
                        main.async{/*we must jump back on main thread, */
                            onOuterComplete(i)
                        }
                    }
                }
                for e in 0..<2{
                    Swift.print("===inner async started e: \(e)===")
                    bg.async{/*do 2 things at the same time*/
                        sleep(2/*IntParser.random(1, 6).uint32*/)/*simulates task that takes between 1 and 6 secs*/
                        onInnerComplete(e)
                    }
                }
            }
        }
        /*
        var i:Int = 0
        func onComplete(/*_ idx:Int,_ result:String*/){
            i += 1
            Swift.print("onComplete: " + "\(i)")
            if(i == arr.count){
                Swift.print("all concurrent tasks completed")
                Swift.print("arr: " + "\(arr)")//[(0, "a", "0a"), (1, "b", "1b"), (2, "c", "2c"), (3, "d", "3d")]
            }
        }
        */
    }
}
