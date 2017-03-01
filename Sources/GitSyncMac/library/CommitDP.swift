import Foundation
@testable import Utils
/**
 * DISCUSSION: The reason we have prevCommits, is to provide an easy way to find which commit from a repo was added to CommitDB
 * CommitDB is a wrapper for git repos. Instead of querrying the many git repos at all time, we rather inteligently cache the data because some parts of the GUI frequently asks for an updated state of the last 100 commits -> this would be cpu instensive to recalculate often so we cache the data instead, and only ask the repos for data that isnt cached
 * TODO: it would be significatly faster if we knew the freshesht commit for each repo. -> store a Dict of repoHash, descChronoDate -> and assert on each add wether to store a new freshest item or not
 */
class CommitDP:DataProvider{
    //var max:Int = 100
}
extension CommitDP{
    /**
     * Adds an item to the sortedArr (at the correct index according to descending chronology, by using a custom binarySearch method)
     * NOTE: items must be added one after the other. A Bulk add method wouldn't work, unless you iterate one by one i guess???
     */
    func add(_ item:[String:String]){
        let closestIdx:Int = CommitDP.closestIndex(items, item, 0, items.endIndex)
        if(!Utils.existAtOrBefore(items,closestIdx,item)){//TODO:ideally this should be handled in the binarySearch algo, but this is a quick fix, that doesnt hurt performance
            //Swift.print("💚 insert at: \(closestIdx) item.date: \(GitDateUtils.gitTime(item["sortableDate"]!))" )
            addItemAt(item, closestIdx)
            //_ = items.insertAt(item, closestIdx)
        }
        if(items.count > /*max*/100){_ = items.popLast()}/*keeps the array at max items*/
    }
    /**
     * This binarySearch finds a suitable index to insert an item in a sorted list (a regular binarySearch would return nil if no match is found, this implmentation returns the closestIndex)
     * NOTE: Binary search, also known as half-interval search or logarithmic search, is a search algorithm that finds the position of a target value within a sorted array.
     * NOTE: Binary search compares the target value to the middle element of the array; if they are unequal, the half in which the target cannot lie is eliminated and the search continues on the remaining half until it is successful.
     * NOTE: Binary search runs in at worst logarithmic time, making O(log n) comparisons, where n is the number of elements in the array and log is the logarithm. Binary search takes only constant (O(1)) space, meaning that the space taken by the algorithm is the same for any number of elements in the array.[5] Although specialized data structures designed for fast searching—such as hash tables—can be searched more efficiently, binary search applies to a wider range of search problems.
     * NOTE: This implementation of binary search is recursive (it calls it self) (Binary search is recursive in nature because you apply the same logic over and over again to smaller and smaller subarrays.)
     * IMPORTANT: Although the idea is simple, implementing binary search correctly requires attention to some subtleties about its exit conditions and midpoint calculation.
     * IMPORTANT: Note that the numbers array is sorted. The binary search algorithm does not work otherwise!
     * DISCUSSION: Is it a problem that the array must be sorted first? It depends. Keep in mind that sorting takes time -- the combination of binary search plus sorting may be slower than doing a simple linear search. Binary search shines in situations where you sort just once and then do many searches.
     * TRIVIA:  YOu can also implement binary serach as iterative implementation by using a while loop
     * TODO: use range instead of start and end int?!?
     */
    static func closestIndex(_ arr:[[String:String]],_ i:[String:String],_ start:Int,_ end:Int) -> Int{
        if(start == end){
            //Swift.print("❤️️ i doesn't exist, this is the closest at: \(start) ")
            return start
        }
        let mid:Int = start + ((end - start) / 2)/*start + middle of the distance between start and end*/
        //Swift.print("mid: " + "\(mid)")
        //Swift.print("arr[mid]: " + "\(arr[mid])")
        if(i["sortableDate"]!.int > arr[mid]["sortableDate"]!.int){/*index is in part1*/
            //Swift.print("a")
            return closestIndex(arr,i,start,mid)
        }else if(i["sortableDate"]!.int < arr[mid]["sortableDate"]!.int){/*index is in part2*/
            //Swift.print("b")
            return closestIndex(arr,i,mid+1,end)
        }else{/*index is at middleIndex*/
            //Swift.print("at middle: \(mid)")
            return mid
        }
    }
}
private class Utils{
    /**
     * Asserts if an item is at or before PARAM: idx
     * NOTE: Usefull in conjunction with ArrayModifier.insertAt()// to assert if an item already exists at that idx or not. to avoid dups
     */
    static func existAtOrBefore(_ arr:[[String:String]],_ idx:Int, _ item:[String:String]) -> Bool {
        func itemAlreadyExistAtIdx()->Bool {return (arr.valid(idx) && arr[idx]["hash"] == item["hash"]) }
        func itemExistsAtIdxBefore()->Bool {return (arr.valid(idx-1) && arr[idx-1]["hash"] == item["hash"])}
        return itemAlreadyExistAtIdx() || itemExistsAtIdxBefore()
    }
    /**
     * New
     */
    static func existAtOrAfter(_ arr:[[String:String]],_ idx:Int, _ item:[String:String]) -> Bool {
        func itemAlreadyExistAtIdx()->Bool {return (arr.valid(idx) && arr[idx]["hash"] == item["hash"]) }
        func itemExistsAtIdxAfter()->Bool {return (arr.valid(idx+1) && arr[idx+1]["hash"] == item["hash"])}
        return itemAlreadyExistAtIdx() || itemExistsAtIdxAfter()
    }
}
//this makes CommitDB unwrappable (XML->CommitDB)
extension CommitDP:UnWrappable{
    static func unWrap<T>(_ xml:XML) -> T? {
        //Swift.print("xml.xmlString.count: " + "\(xml.xmlString.count)")
        let items:[[String:String]?] = unWrap(xml, "items")
        //let prevCommits:[Int:String] = unWrap(xml,"prevCommits")
        return CommitDP(items.flatMap{$0}/*,prevCommits*/) as? T/*flatMap is used to remove any nil values*/
    }
}
