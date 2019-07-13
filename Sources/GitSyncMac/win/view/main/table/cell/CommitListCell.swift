/**
 * Main cell
 */
class CommitListCell: NSTableCell {
	lazy var repoNameLabel: NSLabel = createRepoNameLabel()
	lazy var titleLabel: NSLabel = createTitleLabel()
	lazy var descriptionLabel: NSLabel = createDescriptionLabel()
	lazy var autherLabel: NSLabel = createAutherLabel()
	lazy var dateLabel: NSLabel = createDateLabel()
	lazy var hashLabel: NSLabel = createHashLabel()
	var data: CommitItemData {
		didSet {
			repoNameLabel.setText(data.repoName)
			titleLabel.setText(data.title)
			descriptionLabel.setText(data.description)
			autherLabel.setText(data.auther)
			dateLabel.setText(data.date)
			hashLabel.setText(data.hash)
		}
	}
}
