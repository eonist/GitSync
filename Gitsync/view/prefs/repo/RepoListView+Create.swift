import Cocoa
import Spatial_macOS
import With_mac
import Hybrid_macOS
/**
 * Create
 */
extension RepoListView {
   /**
    * BackButton
    */
   func createBackButton() -> TextButton {//(style: TextButton.defaultStyle, frame: .zero))
      return with(.init(text: "Back", style: TextButton.defaultTextButtonStyle, frame: .zero)) {
         $0.textLabel.font = .systemFont(ofSize: 14)
         $0.textLabel.centerVertically()
         addSubview($0)
         $0.anchorAndSize(to: self, width: 72, height: 24, align: .topLeft, alignTo: .topLeft, offset: .init(x: 12, y: 6))
         $0.upInsideCallBack = onBackButtonClick
      }
   }
   /**
    * AddRepoButton
    */
   func createAddRepoButton() -> TextButton {
      return with(.init(text: "Add repo", style: TextButton.defaultTextButtonStyle, frame: .zero)) {
         $0.textLabel.font = .systemFont(ofSize: 14)
         $0.textLabel.centerVertically()
         addSubview($0)
         $0.anchorAndSize(to: self, width: 72, height: 24, align: .topRight, alignTo: .topRight, offset: .init(x: -12, y: 6))
         $0.upInsideCallBack = onAddButtonClick
      }
   }
   /**
    * RepoList
    */
   func createRepoList() -> RepoList {
      return with(.init()) {
         addSubview($0)
         $0.anchorAndSize(to: self, align: .topLeft, alignTo: .topLeft, offset: .init(x: 0, y: 6 + 24 + 6), sizeOffset: .init(width: 0, height: 6 + 24 + 6) )
      }
   }
}


/**
 * RefreshIndicator
 */
//func createRefreshIndicator() -> RefreshIndicator {
//   return with(.init()) {
//      $0.anchorAndSize(to: self, align:.topCenter, alignTo: topCenter, size: .init(width: 44, height: 44))
//      addSubview($0)
//   }
//}
