/**
 * CommitView
 */
class CommitView: NSView {
	lazy var repoLabel: NSLabel = createRepoLabel()
	lazy var repoTextField: NSTextField = createTextField()
	lazy var titleLabel: NSLabel = createRepoTitleLabel()
	lazy var titleTextField: NSTextField = createTitleTextField()
	lazy var descriptionLabel: NSLabel = createDescriptionLabel()
	lazy var descriptionTextField: NSLabel = createDescriptionTextField()
	/*Confirmation buttons*/
	lazy var confirmationContainer: ConfirmationContainer = createConfirmationContainer
	init(repoName: String, title: String, description: String) {
		repoLabel.setText("Repository: ")
		repoTextField.setText(repoName)
	 	titleLabel.setText("Title: ")
		titleTextField.setText(title)
		descriptionLabel.setText("Description: ")
		descriptionTextField.setText(description)
		_ = confirmationContainer
	}
}
 
