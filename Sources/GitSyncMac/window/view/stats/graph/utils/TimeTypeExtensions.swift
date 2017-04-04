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
    func numOfTimeUnits(_ from:Date,_ until:Date)->Int {
        switch self {
            case .year:
                return from.numOfYears(until)
            case .month:
                return from.numOfMonths(until)
            case .day:
                return from.numOfDays(until)
        }
    }
}
