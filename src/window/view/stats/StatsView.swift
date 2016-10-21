import Foundation

class StatsView:Element {
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        createGraph()
    }
    func createGraph(){
        //day,week,month,year,all (focus on day and week)
        //12a 1 2 3 4 5 6 7 8 9 10
        //M,T,W,T,F,S,S
        
    }
}
