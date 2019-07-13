/**
 * MainDetail
 */
class MainDetailView {
	lazy var backButton: BackButton = createBackButton()
	lazy var repoNameLabel: NSLabel = createRepoNameLabel()
	lazy var titleLabel: NSLabel = createTitleLabel()
	lazy var descriptionLabel: NSLabel = createDescriptionLabel()
	/**
    * Init
    */
	init(repoName: String, title: String, description: String) {
		_ = backButton
		repoNameLabel.setText(repoName)
		titleLabel.setText(title)
		descriptionLabel.setText(description)
	}
}
