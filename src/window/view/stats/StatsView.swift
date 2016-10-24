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
        graph = graphContainer.addSubView(CommitGraph(width,height-48/*,4*/,graphContainer))
        
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
        
        super.init(width, height, parent, id)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
//Simple is the best:
    //show 10 last days (5 on iphone)
    //gestures can iterate time periods back and forth -10 + 10 etc
    //morphs the graph
    //uni dir bounce for show
    //shows stats for all repos where the user is you
    //average commit max for 10 day period
    //days show as: 10/12, 10/13, 10/14 etc etc
    //start at the current date - 10 everytime you enter graph
    //GraphPoints should animate if you set the position differently on iteration
class CommitGraph:Graph{
    override var hValues:[CGFloat] {return [14,8,13,17,25,9,14,20,33,19]}
    override var hValNames:[String] {return ["10/12","10/13","10/14","10/15","10/16","10/17","10/18","10/19","10/20","10/21"]}
}

