/**
 * Create
 */
extension CommitListCell {
	func createRepoNameLabel() -> NSLabel {
	    return with(.init()) {
			  $0.anchorAndSize(to: self, sizeTo: self, align: topLeft, alignTo: .topLeft, height: 24, offset: .init(12,2) ))
		 }
	}
	func createTitleLabel() -> NSLabel {
		return with(.init()) {
			 $0.anchorAndSize(to: repoNameLabel, sizeTo: self, align: topLeft, alignTo: .bottomLeft, height: 32, offset: .init(12,2))
			 addSubview($0)
		}
	}
	func createDescriptionLabel() -> NSLabel {
		return with(.init()) {
			$0.anchorAndSize(to: titleLabel, sizeTo: self, align: topLeft, alignTo: .bottomLeft,  offset: .init(12,2), sizeOffset:.init(width:0,height:-24-32))
			addSubview($0)
	   }
	}
	func createAutherLabel() -> NSLabel {
		return with(.init()) {
		  $0.anchorAndSize(to: self, sizeTo: self, align: topRight, alignTo: .topRight,  offset: .init(-12,2))
		  addSubview($0)
	   }
	}
	func createDateLabel() -> NSLabel {
		return with(.init()) {
		 $0.anchorAndSize(to: autherLabel, sizeTo: self, align: topRight, alignTo: .bottomRight,  offset: .init(0,2))
		 addSubview($0)
	  }
	}
	func createHashLabel() -> NSLabel {
		return with(.init()) {
		 $0.anchorAndSize(to: dateLabel, sizeTo: self, align: topRight, alignTo: .bottomRight,  offset: .init(0,2))
		 addSubview($0)
	  }
	}
}
