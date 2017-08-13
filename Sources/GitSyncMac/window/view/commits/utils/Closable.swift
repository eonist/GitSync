import Foundation

protocol Closable {
    func close()
    func removeFromSuperview()
}
extension Closable{
    func close() {
        self.removeFromSuperview()
    }
}
