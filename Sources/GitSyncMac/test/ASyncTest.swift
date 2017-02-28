import Foundation
@testable import Utils

//do 3 things async, 
//then in each 3 things do 4 things async but do something on mainthread when these 4 things are all finished

class ASyncTest {
    /**
     *
     */
    init(){
        let arr:[Int] = [0,1,2]
        for _ in arr.indices {
            bgQueue.async {
                mainQueue.async {
                    let arr2:[Int] = [0,1,2]
                    arr2.forEach{
                        bgQueue.async{
                            
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
