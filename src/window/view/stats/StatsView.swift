import Foundation

class StatsView:Element {
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
    }
}
