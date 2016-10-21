import Foundation

class StatsView:Element {
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        createGraph()
    }
    func createGraph(){
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
        //Day-mode:
            //create left bar
                //get max count in timeArr
                
            //create bottom bar
                //create 6 Text with the (6part time)
                //each text should have 16.66% width and be centered
                //height should be 24px, top-margin 6 and height 12 and size 12
        
    }
}
