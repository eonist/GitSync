lazy var headerLabel: Label = createHeaderLabel
lazy var issueLabel: Label = createIssueLabel
lazy var proposalLabel: Label = createProposalLabel
lazy var confirmationContainer: Label = createConfirmationContainer

class AutoInitView: NSView {
	init() {
		headerLabel.setText("Auto init:")
		issueLabel.setText("There is no folder in the file path...")
		proposalLabel.setText("Do you want to:")
		_ = confirmationContainer
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
