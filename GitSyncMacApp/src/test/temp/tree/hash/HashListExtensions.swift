import Foundation
@testable import Utils

extension HashList{
    subscript(at:Int) -> String? {//returns key for array idx
        get {return arr[at]}
    }
    subscript(key:String) -> Int? {//returns the internal array idx for key
        get {return dict[key]}
    }
    mutating func add(_ key:String){
        if(!dict.hasKey(key)){
            arr.append(key)//store content in arr
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
    /**
     *
     */
    mutating func add(_ key:String,_ at:Int){
        if(!dict.hasKey(key)){
            _ = arr.insertAt(key, at)//store content in arr
            dict[key] = at//store idx in key
        }else{fatalError("key already exist")}
    }
}
