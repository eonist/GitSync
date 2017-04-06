import Cocoa
@testable import Utils
@testable import Element

/**
 * TODO: When entering the Graph component, you should animate the graph component from the old data to the new data, if there is new data. Very satesfiyng seeing your day commit graph go up after a long day of work
 */
class StatsView:Element {
    var graph:Graph9?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        //Swift.print("StatsView.width: " + "\(width)")
        //Swift.print("StatsView.height: " + "\(height)")
        createGraph()
    }
    func createGraph(){
        let graphContainer = addSubView(Section(width,height,self,"graph"))
        //graph = graphContainer.addSubView(CommitGraph(width,height-48/*,4*/,graphContainer))
        graph = graphContainer.addSubView(Graph9(width,height-48,graphContainer))
    }
}
