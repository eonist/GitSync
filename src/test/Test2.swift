import Foundation
//Continue here:
    //runing NSTask on a background thread is now working, its a bit of a hassle to setup ✅
        //try to clean the setup process ✅
        //try retriving the commits from repo on a background thread ✅
        //try to make the speedy commit count method (combines rev-list and show->error etc)
    //try to speed test the retrival of commits from repo✅
        //first with the freshness algo set manualy✅
        //then do a speed test where the repo list is not optimally sorted✅
class Test2 {
    init(){
        
        //_ = ThreadTesting()
        
        //_ = ASyncTaskTest()
        _ = PopulateCommitDB()
        
        
        //test!.refresh()
        //refreshCommitDBTest()
        
        
        //reflectionDictTest()
        //ioTest()
        //dataBaseTest()
        //chronologicalTime2GitTimeTest()
        //commitDateRangeCountTest()
    }
    /**
     * NOTE: Even though the NSTask isn't explicitly run on a background thread, it seems to be anyway, as it blocks other background threads added later, actually while doing a Repeating time intervall test, it blocked the timer. So its probably not runnign on a background thread after all
     */
    func refreshCommitDBTest(){
        CommitDBUtils.refresh()
    }
    /**
     * Finds commit count from a date until now
     */
    func commitDateRangeCountTest(){
        let chronoTime = "20161111205959"
        let gitTime = chronoTime.insertCharsAt([("-",4),("-",6),(" ",8),(":",10),(":",12)])//2016-11-11 20:59:59
        Swift.print("gitTime: " + "\(gitTime)")
        //gitTime = gitTime.encode()!
        Swift.print("gitTime: " + "\(gitTime)")
        
        let repoXML = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)//~/Desktop/repo2.xml
        let repoList = XMLParser.toArray(repoXML)//or use dataProvider
        Swift.print("repoList.count: " + "\(repoList.count)")
        
        let localPath:String = repoList[1]["local-path"]!
        Swift.print("localPath: " + "\(localPath)")
        
        let commitCount = GitUtils.commitCount(localPath, after: gitTime)
        Swift.print("commitCount: " + "\(commitCount)")
    }
    /**
     * //YYYYMMDDhhmmss -> YYYY-MM-DD hh:mm:ss
     */
    func chronologicalTime2GitTimeTest(){//format chronological date to git time-> "2016-11-12 00:00:00"
        let githubTime = "20161111205959".insertCharsAt([("-",4),("-",6),(" ",8),(":",10),(":",12)])//2016-11-11 20:59:59
        Swift.print(githubTime)
        
    }
    /**
     *
     */
    func reflectionDictTest(){
        
        let temp:Temp = Temp([0:"test",3:"testing",5:"more testing"])//create a dict
        let xml:XML = Reflection.toXML(temp) //reflect the dict to xml
        Swift.print(xml.XMLString)//print the xml
        
        let newInstance:Temp = Temp.unWrap(xml)!//unwrap the xml to dict
        newInstance.someDict.forEach{
            Swift.print("key: \($0.0) value: \($0.1)")
        }
        //Swift.print("xml.XMLString: " + "\(xml.XMLString)")
    }
    /**
     * Reflection and unwrapping with commitDB
     */
    func ioTest(){
        
        
        Swift.print("ioTest()")
        let commitDB = CommitDBCache.read()
        
        Swift.print("Printing sortedArr after unwrap: ")
        commitDB.sortedArr.forEach{Swift.print($0.sortableDate)}
        Swift.print("Printing prevCommits after unwrap: ")
        //commitDB.prevCommits.forEach{Swift.print("key: \($0.0) value: \($0.1)")}
        /*
        commitDB.add(Commit("","","","","",201609,"f2o33f",3))
        CommitDBCache.write(commitDB)
        */
    }
    /**
     *
     */
    func dataBaseTest(){
        
        
        let commitDB = CommitDB()
        commitDB.add(Commit("","","","","",201602,"fak42a",0))
        commitDB.add(Commit("","","","","",201608,"2fae23",0))
        commitDB.add(Commit("","","","","",201601,"gr24g2",5))
        commitDB.add(Commit("","","","","",201611,"24ggq2",2))
        commitDB.add(Commit("","","","","",201606,"esvrg3",1))
        commitDB.add(Commit("","","","","",201606,"esvrg3",1))
        commitDB.add(Commit("","","","","",201506,"g46j45",6))
        commitDB.sortedArr.forEach{Swift.print($0.sortableDate)}
        
        /*
        let xml = Reflection.toXML(commitDB)/*Reflection*/
        Swift.print(xml.XMLString)
        let newInstance:CommitDB = CommitDB.unWrap(xml)!/*UnWrapping*/
        Swift.print("Printing sortedArr after unwrap: ")
        newInstance.sortedArr.forEach{Swift.print($0.sortableDate)}
        */
        //Swift.print("Printing prevCommits after unwrap: ")
        //newInstance.prevCommits.forEach{Swift.print("key: \($0.0) value: \($0.1)")}
    }
}
