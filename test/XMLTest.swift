//xml parsing test

import Foundation
import Cocoa

let path = "//Users/<path>/someFile.xml"

var err: NSError?
let content = String.stringWithContentsOfFile(path, encoding: NSUTF8StringEncoding, error: &err)
