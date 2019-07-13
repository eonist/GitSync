class ErrorView {
	lazy var titleLabel: Label = createTitleLabel()
	lazy var descriptionLabel: Label = createDescriptionLabel()
	lazy var confirmationContainer: Label = createConfirmationContainer()
	init(title: String = "Error: ", description: String = "Git is not installed, please install it"){
		titleLabel.setText(title)
		descriptionLabel.setText(description)
		_ = confirmationContainer
	}
}
