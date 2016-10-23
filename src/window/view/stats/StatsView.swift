import Foundation
/**
 * TODO: Consider making the graph component bouncy and zoomable (with time elements that tesselate)
 */
class StatsView:Element {
    var graph:Graph?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        Swift.print("StatsView.width: " + "\(width)")
        Swift.print("StatsView.height: " + "\(height)")
        createGraph()
    }
    func createGraph(){
        let graphContainer = addSubView(Container(width,height,self,"graph"))
        graphContainer
        graph = graphContainer.addSubView(MonthGraph(width,height-48,graphContainer))
        
        //GraphTypePicker
        let tabBar:Section = self.addSubView(Section(NaN, NaN, self, "tabBar"))
        let btn1 = tabBar.addSubView(SelectTextButton(NaN,NaN,"Month",true,tabBar,"first"))
        let btn2 = tabBar.addSubView(SelectTextButton(NaN,NaN,"Week",false,tabBar,"second"))
        let btn3 = tabBar.addSubView(SelectTextButton(NaN,NaN,"Day",false,tabBar,"third"))
        let selectGroup = SelectGroup([btn1,btn2,btn3],btn1)//SelectParser.selectables(card)
        selectGroup
        
        //Time Iterator Left and right stepper use the left and right arrows similar to the up and down arrows in stepper (right aligned) (use the stepper just horizontally aligned)
        let stepper:LeverStepper = addSubView(LeverStepper(NaN,NaN,0,1,Int.min.cgFloat,Int.max.cgFloat,0,100,200,self))
        stepper
        
        
        
        //day,week,month,year,all (focus on day and week)
        //12a 1a 2a 3a 4a 5a 6a 7a 8a 9a 10a 11a 12p 1p 2p 3p 4p 5p 6p 7p 8p 9p 10p 11p
        //00:00, 01:00, 02
        //00,02,04,06,08,10,12,14,16,18,20,22,24 (12 part time)
        //00:00,04:00,08:00,12:00,16:00,20:00 ()
        //00,04,08,12,16,20 (6 part time)
        
        //for all repos:
            //get the commits from today where the user is Eonist
                //store the time in an [[Int]] (basically a arr with an arr of times)
                //if time is between 20:00 and 00:00, add to timeArr[0]
        
        
        //DayGraph:Graph
            //override var timeUnits etc
        //YearGraph
        //AllGraph
    }
}

class WeekGraph:Graph{
    override var hValNames:[String] {return ["M","T","W","T","F","S","S"]}
}
class MonthGraph:Graph{
    override var hValNames:[String] {return ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]}
    override var hValues:[CGFloat] {return [14,8,13,17,25,9,14,20,33,25,15,19]}
}

