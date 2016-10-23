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
        graph = graphContainer.addSubView(YearGraph(width,height-48/*,4*/,graphContainer))
        
        //GraphTypePicker
        let tabBar:Section = self.addSubView(Section(NaN, NaN, self, "tabBar"))
        let btn0 = tabBar.addSubView(SelectTextButton(NaN,NaN,"Year",false,tabBar,"first"))
        let btn1 = tabBar.addSubView(SelectTextButton(NaN,NaN,"Month",true,tabBar,"second"))
        let btn2 = tabBar.addSubView(SelectTextButton(NaN,NaN,"Week",false,tabBar,"third"))
        let btn3 = tabBar.addSubView(SelectTextButton(NaN,NaN,"Day",false,tabBar,"fourth"))
        let selectGroup = SelectGroup([btn0,btn1,btn2,btn3],btn1)//SelectParser.selectables(card)
        selectGroup
        
        //You need some kind of indicator value on which time you are currently at

        func onSelectGroupChange(event:Event){
            Swift.print("event.selectable: " + "\(event)")
            if(selectGroup.selected === btn0){
                Swift.print("set Graph to YearGraph")
            }else if(selectGroup.selected === btn1){
                Swift.print("set Graph to MonthGraph")
            }else if(selectGroup.selected === btn2){
                Swift.print("set graph to WeekGraph")
            }else if(selectGroup.selected === btn3){
                Swift.print("set graph to DayGraph")
            }
        }
        selectGroup.event = onSelectGroupChange
        
        //Time Iterator Left and right stepper use the left and right arrows similar to the up and down arrows in stepper (right aligned) (use the stepper just horizontally aligned)
        let stepper:LeverStepper = addSubView(LeverStepper(NaN,NaN,0,1,Int.min.cgFloat,Int.max.cgFloat,0,100,200,self))
        stepper
        
        //day,week,month,year,all (focus on day and week)
        //12a 1a 2a 3a 4a 5a 6a 7a 8a 9a 10a 11a 12p 1p 2p 3p 4p 5p 6p 7p 8p 9p 10p 11p
        //00:00, 01:00, 02
        //00,02,04,06,08,10,12,14,16,18,20,22,24 (12 part time)
        //00:00,04:00,08:00,12:00,16:00,20:00 ()
        //00,04,08,12,16,20 (6 part time)
        
        //Night 00, Morning 06, Noon 12, evening: 18 night 00
        
        //00,03,06,09,12,15,18,21,00
        //12a,03a,06a,09a,12a,03p,06p,09p,12a
        
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
/**
 * NOTE: You need to think week 1 - 52, and teselate months into 4 and then based on the mid day in this teselation derive the week-nr. NSDate probably has support for this
 */
class WeekGraph:Graph{
    override var hValues:[CGFloat] {return [4,2,3,7,5,0,1]}
    override var hValNames:[String] {return ["M","T","W","T","F","S","S"]}
}
class MonthGraph:Graph{
    override var hValues:[CGFloat] {
        var arr:[CGFloat] = []
        for _ in 0..<numOfDaysInMonth{
            let val:CGFloat = NumberParser.random(4, 24).cgFloat//generate hValues via random
            arr.append(val)
        }
        return arr
    }
    override var hValNames:[String] {
        var arr:[String] = []
        for i in 1...numOfDaysInMonth{//you need 1 until numOfDaysInMonth as hvalnames
            arr.append(i.string)
        }
        return arr
    }
    var numOfDaysInMonth:Int
    var curMonth:Int
    init(_ width: CGFloat, _ height: CGFloat,_ curMonth:Int, _ parent: IElement?, _ id: String? = nil) {
        self.curMonth = curMonth
        let date:NSDate = NSDate.createDate(nil,4)!
        numOfDaysInMonth = date.numOfDaysInMonth
        
        
        //so the month graph is a bit tricky:
            //you have to divide it by week, so the num of vertical lines differentiate for each month, depending how the week hit the month etc, and how many days are in the month, no month graph is the same
            //all Sundays get a GraphPoint
            //the start and end of a month also gets a GraphPoint which is calculated by the prev and next week (then calc the diff between 2 weeks collected values, then the num of days untill that day, use this to multiply the value....its not so tricky to make)
            //figure out how to add the weeks to 1 value etc
            //Also keep in mind that you draw the GraphPoint for the surounding 3.5 days from left and right of where the GraphPoint is drawn. (think of the graph as an infinte graph that you see snapshots of)
            //disregard the above, the valie is for day 1 until 7 in a week. from monday (basically values for week 44 on the start of week 44)
            //Actually, just do this simpler: show the last 10 days (10/12,10/13,10/14 etc etc)
        
        //what if you do:
            //year,month,day
            //year: 14,15,16 etc (only 2 if time only spans 1 year) (max 10 year, 5 on iphone)
            //month: jan - dec (12) (6 month on iphone)
            //day: 10 days (5 days on iphone)
        
            //gestures then bounce the graph left,right, up and down
                //left and right gestures transform the graph to earlier time periods

        
        super.init(width, height, parent, id)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
/**
 * the values are the collected values from 1 to end of month
 */
class YearGraph:Graph{
    override var hValNames:[String] {
        //return ["Jan,Feb,Mar","Apr,May,Jun","Jul,Aug,Sep","Oct,Nov,Dec"]
        //return ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        return ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
        //return ["Jan","","","Apr","","","Jul","","","Oct","",""]
        //return ["1","2","3","4","5","6","7","8","9","10","11","12"]
    }
    override var hValues:[CGFloat] {
        //return [45,65,53,77]
        return [14,8,13,17,25,9,14,20,33,25,15,19]
    }
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement?, _ id: String? = nil) {
        super.init(width, height, parent, id)
        
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

