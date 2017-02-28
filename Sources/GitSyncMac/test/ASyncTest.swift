import Foundation
@testable import Utils

//do 3 things async, 
//then in each 3 things do 2 things async but do something on mainthread when these 4 things are all finished

class ASyncTest {
    /**
     *
     */
    init(){
        let group = DispatchGroup()
        Swift.print("1")
        for _ in 0..<4{
            bg.async{/*do 2 things at the same time*/
                group.enter()
                Swift.print("iterate")
                sleep(IntParser.random(2, 3).uint32)/*simulates task that takes between 1 and 6 secs*/
                group.leave()
            }
        }
        
        group.wait()
        group.notify(queue: bg, execute: {
            Swift.print("🏁 allTasksCompleted: 🏁")
        })
        
    }
}
/*
for i in 0..<3{
    bg.async {/*do 3 things at the same time*/
        for e in 0..<2{
            bg.async{/*do 2 things at the same time*/
                group.enter()
                sleep(IntParser.random(1, 6).uint32)/*simulates task that takes between 1 and 6 secs*/
                Swift.print("i: \(i) e:\(e)")
                group.leave()
            }
        }
    }
}
*/
