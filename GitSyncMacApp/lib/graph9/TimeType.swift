import Foundation

enum TimeType:Int {
    case day = 0,month,year
    static var types:[TimeType] {return [.day,.month,.year]}
}
