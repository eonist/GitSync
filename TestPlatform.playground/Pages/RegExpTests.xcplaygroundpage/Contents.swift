//: [Previous](@previous)

import Foundation

let str = "abc 123 abc 123 abc 123 xyz"
let pattern = "[a-zA-Z]{3}"
let match = RegExpParser.match(str, pattern)
match