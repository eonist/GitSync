import Foundation
@testable import Utils

extension ProtoTypeView{
    enum Styles{
        enum Modal{
            static let initial:String = {
                var css:String = ""
                css += "Button#modalBtn{"
                css += "fill:#66CDAD,~/Desktop/ElCapitan/svg/question.svg white;"//fill:blue;
                css += "width:\(ProtoTypeView.Modal.initial.w)px,50px;"
                css += "height:\(ProtoTypeView.Modal.initial.h)px,50px;"
                css += "corner-radius:\(ProtoTypeView.Modal.initial.fillet)px;"
                css += "margin-top:0px,25px;"
                css += "margin-left:0px,25px;"
                css += "clear:none;"
                css += "float:none;"
                css += "}"
                return css
            }()
        }
    }
}
