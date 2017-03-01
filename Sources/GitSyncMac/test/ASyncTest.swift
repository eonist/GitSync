import Foundation
@testable import Utils

//do 3 things async, 
//then in each 3 things do 2 things async but do something on mainthread when these 4 things are all finished

class ASyncTest {
    /**
     * Next implement the bellow in your example:
     */
    
    //Continue here: Try using blox or read more about DispatchGroups
    
    init(){
        let group = DispatchGroup()
        
        bg.async{/*do 2 things at the same time*/
            group.enter()
            sleep(IntParser.random(3, 6).uint32)/*simulates task that takes between 1 and 6 secs*/
            group.leave()
        }
        
        group.wait()
        group.notify(queue: bg, execute: {
            Swift.print("🏁 group completed: 🏁")
        })
    }
}

