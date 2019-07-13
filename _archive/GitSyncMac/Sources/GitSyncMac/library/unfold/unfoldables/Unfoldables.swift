import Foundation
@testable import Utils
@testable import Element

class Unfoldables {
    /**
     * We store types as an array as its easier/more dynamic than a switch
     */
//    static let arr:[UnFoldable.Type] = [Text.self,TextInput.self,RadioButton.self,CheckBoxButton.self,CheckBoxButton2.self,TextButton.self,Text.self,FilePicker.self,Container.self,Section.self]
    /**
     * Converts the array to dictionary
     */
//    static let dict:[String:UnFoldable.UnFoldMethod] = arr.reduce([:])  {
//        var dict:[String:UnFoldable.UnFoldMethod] = $0
//        Swift.print("$1: " + "\($1)")
//
//        dict["\($1)"] = ($1 as UnFoldable.Type).unfold
//        return dict
//    }
    /**
     * We store types as a dict as its easier/more dynamic than a switch
     * IMPORTANT: ⚠️️ Can't store just class types. the unfold method infers wrongly if there is inheritance
     * EXAMPLE: let item = (Unfoldables.dict2["\(RadioButton.self)"])?([:])
     * EXAMPLE: Swift.print("item: " + "\(item)")//item: Optional(<Element.RadioButton: 0x101a13d00>)
     */
    static let dict:[String:UnFoldable.UnFoldMethod] = {
        return ["\(Text.self)":Text.unfold,
                "\(TextInput.self)":TextInput.unfold,
                "\(RadioButton.self)":RadioButton.unfold,
                "\(CheckBoxButton.self)":CheckBoxButton.unfold,
                "\(CheckBoxButton2.self)":CheckBoxButton2.unfold,
                "\(TextButton.self)":TextButton.unfold,
                "\(FilePicker.self)":FilePicker.unfold,
                "\(Container.self)":Container.unfold,
                "\(Section.self)":Section.unfold
                ]
    }()
}

