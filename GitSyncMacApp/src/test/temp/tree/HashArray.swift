import Foundation
@testable import Utils
/**
 * NOTE: key gives you idx, idx gives you content
 * https://github.com/raywenderlich/swift-algorithm-club/tree/master/Hash%20Table
 * NOTE: we could use T:Hashable, but no need atm
 */
struct HashArray{
    var dict:[String:Int] //Dictionary holdes the key and index of the content.
    var arr:[Any] //Array holds the content
    init(_ dict:[String:Int] = [:],_ arr:[Any] = []){
        self.dict = dict
        self.arr = arr
    }
}
extension HashArray{
    subscript(key:String) -> Any? {
        get {
            return get(key)
        }
        set {
            add(key,newValue!)
        }
    }
    fileprivate mutating func add(_ key:String, _ content:Any){
        if(!dict.hasKey(key)){
            arr.append(content)//store content in arr
            let idx:Int = arr.count-1
            dict[key] = idx//store idx in key
        }else{fatalError("key already exist")}
    }
    mutating func remove(_ key:String){
        if let idx:Int = dict[key]{//make sure the key exists
            dict.removeValue(forKey: key)//remove key and val from dict
            _ = arr.removeAt(idx)//remove item from arr
        }else{fatalError("key does not exist")}
    }
    fileprivate func get(_ key:String)->Any?{
        if let idx:Int = dict[key]{
            Swift.print("idx: " + "\(idx)")
            return arr[idx]
        }
        return nil
    }
}
