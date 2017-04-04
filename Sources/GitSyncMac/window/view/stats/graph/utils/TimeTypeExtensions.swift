import Foundation
@testable import Utils

extension TimeType{
    func offsetBy(_ date:Date,_ offset:Int)->Date {
        switch self {
            case .year:
                return DateModifier.offsetByYears(date,offset)
            case .month:
                return DateModifier.offsetByMonths(date,offset)
            case .day:
                return DateModifier.offsetByDays(date,offset)
        }
    }
    var numOfTimeUnits:Int
}
