import Foundation

public enum TimeType:Int {
    case day = 0,month,year
    static public var types:[TimeType] {return [.day,.month,.year]}
}
