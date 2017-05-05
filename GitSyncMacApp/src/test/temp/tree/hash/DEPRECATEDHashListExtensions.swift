import Foundation
@testable import Utils

extension DEPRECATEDHashList {
    subscript(at:Int) -> [Int]? {//convenience
        get {return arr[at].array({$0.int})}
    }
    subscript(at:Int) -> String? {//returns key for array idx
        get {return arr[at]}
    }
    subscript(key:String) -> Int? {//returns the internal array idx for key
        get {return dict[key]}
    }
    /**
     * Adds key
     */
    mutating func add(_ key:String){
        if(!dict.hasKey(key)){
            arr.append(key)//store content in arr
            let idx:Int = arr.count-1
            dict[key] = idx//store idx in key
        }else{fatalError("key already exist")}
    }
    /**
     * Adds key at index
     */
    mutating func add(_ key:String,_ at:Int){
        if(!dict.hasKey(key)){
            _ = arr.insertAt(key, at)//store content in arr
            dict[key] = at//store idx in key
        }else{fatalError("key already exist")}
    }
    /**
     * Add multiple
     */
    mutating func add(_ at:Int, _ indecies:[[Int]]){
        var i:Int = at
        indecies.forEach{
            let key:String = $0.string
            add(key,i)
            i += 1
        }
    }
    /**
     * Removes key
     */
    mutating func remove(_ key:String){
        if let idx:Int = dict[key]{//make sure the key exists
            _ = arr.removeAt(idx)//remove item from arr
            dict.removeValue(forKey: key)//remove key and val from dict
        }else{fatalError("key does not exist: \(key)")}
    }
    /**
     * Removes key at index
     */
    mutating func removeAt(_ key:String, _ at:Int){
        //Swift.print("dict: " + "\(dict)")
        if(dict.hasKey(key)){//make sure the key exists
            _ = arr.remove(at:at)
            dict.removeValue(forKey:key)//remove key and val from dict
        }else{fatalError("key does not exist: \(key)")}
    }
    /**
     * Removes at
     */
    mutating func remove(_ at:Int){
        let key:String = arr[at]
        removeAt(key, at)
    }
}
