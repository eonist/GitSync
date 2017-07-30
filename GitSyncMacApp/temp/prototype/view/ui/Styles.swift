import Foundation
@testable import Utils

extension ProtoTypeView{
    enum Styles{
        enum Modal{
            static let initial:String = {
                var css:String = ""
                css += "Button#modalBtn{"
                css += "fill:#\(ProtoTypeView.Modal.Colors.initial.hexString),~/Desktop/ElCapitan/svg/question.svg white;"//fill:blue;
                css += "width:\(ProtoTypeView.Modal.initial.w)px,\(ProtoTypeView.Modal.svgSize.w)px;"
                css += "height:\(ProtoTypeView.Modal.initial.h)px,\(ProtoTypeView.Modal.svgSize.h)px;"
                css += "corner-radius:\(ProtoTypeView.Modal.initial.fillet)px;"
                css += "margin-top:0px,\(ProtoTypeView.Modal.svgSize.w/2)px;"
                css += "margin-left:0px,\(ProtoTypeView.Modal.svgSize.w/2)px;"
                css += "clear:none;"
                css += "float:none;"
                css += "}"
                return css
            }()
        }
        enum PromptButton{
            static let initial:String = {
                var css:String = ""
                css += "Button#prompt{"
                css += "width:\(ProtoTypeView.PromptButton.initial.size.w)px;"
                css += "height:\(ProtoTypeView.PromptButton.initial.size.h)px;"
                css += "fill:purple;"
                css += "corner-radius:20px;"
                css += "clear:none;"
                css += "float:none;"
                css += "}"
                css += "Button#prompt:down{"
                css += "fill:grey;"
                css += "}"
                return css
            }()
        }
    }
}
