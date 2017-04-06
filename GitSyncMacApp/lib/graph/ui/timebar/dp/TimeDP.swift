import Foundation
@testable import Utils
@testable import Element

class TimeDP:DataProvider{
    var yearRange:Range<Int>
    init(_ yearRange:Range<Int>) {
        self.yearRange = yearRange
    }
}
