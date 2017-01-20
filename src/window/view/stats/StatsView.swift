import Cocoa
/**
 * TODO: When entering the Graph component, you should animate the graph component from the old data to the new data, if there is new data. Very satesfiyng seeing your day commit graph go up after a long day of work
 */
class StatsView:Element {
    var graph:CommitGraph?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        Swift.print("StatsView.width: " + "\(width)")
        Swift.print("StatsView.height: " + "\(height)")
        createGraph()
    }
    func createGraph(){
        let graphContainer = addSubView(Container(width,height,self,"graph"))
        graph = graphContainer.addSubView(CommitGraph(width,height-48/*,4*/,graphContainer))
        
        //for all repos:
            //get the commits from today where the user is Eonist
                //store the time in an [[Int]] (basically a arr with an arr of times)
                //if time is between 20:00 and 00:00, add to timeArr[0]
    }
}