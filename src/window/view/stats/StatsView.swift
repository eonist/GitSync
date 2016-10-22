import Foundation

class StatsView:Element {
    var graph:Graph?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        createGraph()
    }
    func createGraph(){
        graph = addSubView(Graph(width,height,self))
        //day,week,month,year,all (focus on day and week)
        //12a 1a 2a 3a 4a 5a 6a 7a 8a 9a 10a 11a 12p 1p 2p 3p 4p 5p 6p 7p 8p 9p 10p 11p
        //00:00, 01:00, 02
        //00,02,04,06,08,10,12,14,16,18,20,22,24 (12 part time)
        //00:00,04:00,08:00,12:00,16:00,20:00 ()
        //00,04,08,12,16,20 (6 part time)
        //M,T,W,T,F,S,S
        //Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec
        
        //for all repos:
            //get the commits from today where the user is Eonist
                //store the time in an [[Int]] (basically a arr with an arr of times)
                //if time is between 20:00 and 00:00, add to timeArr[0]
        
        
        //DayGraph:Graph
            //override var timeUnits etc
        //WeekGraph
        //MonthGraph
        //YearGraph
        //AllGraph
        
                
        //GraphTypePicker
            //TabBar with: Day/Week/Month (center aligned)
        //Time Iterator Left and right stepper use the left and right arrows similar to the up and down arrows in stepper (right aligned) (use the stepper just horizontally aligned)
        
        //Consider making the graph component bouncy and zoomable (with time elements that tesselate)
    }
}
