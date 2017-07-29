import Cocoa
@testable import Utils
@testable import Element

extension ProtoTypeView {
    /**
     * Frame animation for promptButton
     */
    func promptButtonAnim(point:CGPoint){
        disableAnim {
            self.promptBtn.layer?.position = point
        }
    }
    

}
