import Foundation

class TextButton:Button {
    init(title:String = ""){
        super.init()
        self.title = title
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}