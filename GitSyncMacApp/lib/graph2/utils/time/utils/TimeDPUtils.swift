import Foundation

class TimeDPUtils {
    static func timeDP(_ timeType:TimeType, _ range:Range<Int>)->TimeDP{
        let dp:TimeDP = {
            switch timeType{
                case .day:
                    return DayDP(range)
                case .month:
                    return MonthDP(range)
                case .year:
                    return YearDP(range)
            }
        }()
        return dp
    }
}
