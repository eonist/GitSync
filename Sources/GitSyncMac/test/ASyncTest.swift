import Foundation
@testable import Utils

class ASyncTest {
    /**
     *
     */
    init(){
        var arr:[(i:Int,s:String,result:String)] = [(0,"a",""),(1,"b",""),(2,"c",""),(3,"d","")]
        var i:Int = 0
        func onComplete(/*_ idx:Int,_ result:String*/){
            i += 1
            Swift.print("onComplete: " + "\(i)")
            if(i == arr.count){
                Swift.print("all concurrent tasks completed")
                Swift.print("arr: " + "\(arr)")//[(0, "a", "0a"), (1, "b", "1b"), (2, "c", "2c"), (3, "d", "3d")]
            }
        }
        for i in arr.indices {
            bgQueue.async {
                let res:String = arr[i].i.string + arr[i].s
                mainQueue.async {
                    arr[i].result = res//assinging of values must happen on mainThread
                    onComplete()
                }
            }
        }
    }
}
