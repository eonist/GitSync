import Foundation
import Cocoa

class Section:Element {//Unlike Container, section can have a style applied
    init(_ style:IStyle, _ width: Int = 100, _ height: Int = 100) {
        super.init(width, height, style)

    }
    /*
    * Required by super class
    */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}