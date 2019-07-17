
import Cocoa
import Hybrid_macOS
/**
 * AutoInitView
 */
class AutoInitView: NSView {
   override open var isFlipped: Bool { return true }/* TopLeft orientation */
   lazy var headerLabel: NSLabel = createHeaderLabel()
   lazy var issueTextInput: TextInput = createIssueTextInput()
   lazy var proposalTextInput: TextInput = createProposalTextInput()
   lazy var confirmationContainer: ConfirmationContainer = createConfirmationContainer()
   override public init(frame: CGRect) {
      Swift.print("AutoInitView.init")
      super.init(frame: frame)
      self.wantsLayer = true /* if true then view is layer backed */
      self.layer?.backgroundColor = NSColor.white.cgColor
      _ = headerLabel//.setText("")
      _ = issueTextInput//.setText("There is no folder in the file path...")
      _ = proposalTextInput//.setText("Do you want to:")
      _ = confirmationContainer
   }
   /**
    * Boilerplate
    */
   required init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}


// "autoInitView":[
// {"type":"Text","id":"header","text":"Auto init:"},
// {"type":"Text","id":"issueText","text":"There is no folder in the file path..."},
// {"type":"Text","id":"proposalText","text":"Do you want to:"},
// {"type":"TextButton","id":"cancel","text":"Cancel"},
// {"type":"TextButton","id":"ok","text":"OK"}
// ],

//🏀
