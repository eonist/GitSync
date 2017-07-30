import Foundation
@testable import Utils

extension ProtoTypeView{
    enum Styles{
        enum Modal{
            static let initial:String = {
                var css:String = ""
                css += "Button#modalBtn{"
                css += "fill:#\(Colors.Modal.initial.hexString),~/Desktop/ElCapitan/svg/question.svg white;"//fill:blue;
                css += "width:\(Modal.initial.w)px,\(Modal.svgSize.w)px;"
                css += "height:\(Modal.initial.h)px,\(Modal.svgSize.h)px;"
                css += "corner-radius:\(Modal.initial.fillet)px;"
                css += "margin-top:0px,\(Modal.svgSize.w/2)px;"
                css += "margin-left:0px,\(Modal.svgSize.w/2)px;"
                css += "clear:none;"
                css += "float:none;"
                css += "}"
                return css
            }()
        }
        enum PromptButton{
            static let initial:String = {
                var css:String = ""
                css += "TextButton#prompt{"
                css += "width:\(ProtoTypeView.PromptButton.initial.size.w)px;"
                css += "height:\(ProtoTypeView.PromptButton.initial.size.h)px;"
                css += "fill:\(Colors.PromptButton.Background.idle.hexString);"
                css += "corner-radius:\(ProtoTypeView.PromptButton.initial.size.h/2)px;"
                css += "clear:none;"
                css += "float:none;"
                css += "}"
                /*TextButton down*/
                css += "Button#prompt:down{"
                css += "fill:\(Colors.PromptButton.Background.down.hexString);"
                css += "}"
                /*TextButton Text*/
                css += "TextButton Text{"
                css += "float:left;"
                css += "clear:left;"
                css += "width:100%;"
                css += "height:40px;"
                css += "margin-top:8px;"
                css += "font:Helvetica Neue;"
                css += "size:24px;"
                css += "wordWrap:true;"
                css += "type:dynamic;"
                css += "background:false;"
                css += "backgroundColor:yellow;"
                css += "border:false;"
                css += "align:center;"
                css += "color:#\(Colors.PromptButton.Text.idle.hexString);"
                css += "selectable:false;"
                css += "multiline:false;"
                css += "}"
                /*TextButton down Text*/
                css += "TextButton:down Text{"
                css += "color:#\(Colors.PromptButton.Text.down.hexString);"
                css += "}"
                return css
            }()
        }
    }
}
