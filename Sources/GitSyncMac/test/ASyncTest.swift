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
        /**
         *
         */
        func allOuterTasksCompleted(){
            Swift.print("🏁 allOuterTasksCompleted: 🏁")
        }
        func onOuterComplete(_ IDX:Int){
            Swift.print("all inner async tasks completed on outer async id: \(IDX)")
            outerIdx += 1
            Swift.print("outerIdx: " + "\(outerIdx)")
            if(IDX == 3){
                allOuterTasksCompleted()
                Swift.print("finished")
            }
        }
        for i in 0..<3{//do 3 things async
            bg.async {
                main.async{//back on main thread
                    Swift.print("---outer async started i: \(i)---")
                    var idx:Int = 0
                    
                    func onInnerComplete(_ index:Int){
                        Swift.print("inner async task completed e: \(index)")
                        idx += 1
                        if(idx == 2){
                            onOuterComplete(i)
                        }
                    }
                    for e in 0..<2{
                        Swift.print("===inner async started e: \(e)===")
                        bg.async{//do 2 things async
                            sleep(IntParser.random(1, 6).uint32)
                            //Swift.print("i: \(i) e: \(e)")
                            onInnerComplete(e)
                        }
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
