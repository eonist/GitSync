import Foundation

//the next experiment is:
    //The pinch gesture needs to zoom iterativly (y:2,m:1,d:0) (also Week and Hour later, maybe premium?)
    //The TimeBar needs to morph between: M,T,W,T,F,S,S and Jan,Feb,Mar, 12,13,14,15,16,17
    //When you pinch in, you record the mouse.x, and zoom into that time-range (when you zoom out this doesn't matter)
        //When you go into the new timeUnit, you do it with a progress value attached.
            //Then you render the range for that progress val
            //you need the entire timespan for the value bar
                //calculate this by asking all repos for the date of their first commit. now..<firstCommitDates.min()
                //Use fastList tech to render the timebar.
                    //use a sudo range to test this first. 
                    //dont use fastList at first. just use small data sets. 
                    //you need to add faux dates when the ranges are too small. 
                        //if you only commited in 17 you still need 6 other years prior to fill the gap
                            //the same goes for other timeunits you may have only commited in june, but need 6 months prior to fill the bar
                            //also fill the bar if there are no commits: 6_months_prior..<now, same with days and year


//1. Task:
    //draw the different transitions and logics on paper first, find the weak spots ✅
    //3 time-levels with default 7 items.
    //on gesture pinch zoom in out
        //change the text in the timebar on pinch change

//2. Task:
    //create a sudo time data structure
    //figure out how to fill in the blanks when that occurs
    //the mouse cursor closness to a GraphPoint decides where the zoom will occure.
        //you zoom in at the beginning of the month. begining of year, begining of day etc.
class Graph5 {
    
}
