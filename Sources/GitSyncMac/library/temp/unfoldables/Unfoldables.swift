import Foundation
@testable import Utils
@testable import Element

class Unfoldables {
    /**
     * We store types as an array as its easier/more dynamic than a swich
     */
    static let arr:[UnFoldable.Type] = [Text.self,TextInput.self,RadioButton.self,CheckBoxButton.self,TextButton.self,Text.self,FilePicker.self,Container.self]
    /**
     * Converts the array to dictionary
     */
    static let dict:[String:UnFoldable.UnFoldMethod] = arr.reduce([:])  {
        var dict:[String:UnFoldable.UnFoldMethod] = $0
        dict["\($1)"] = ($1 as UnFoldable.Type).unfold
        return dict
    }
}

