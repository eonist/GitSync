### Continue here:
    //store xml to disk
    //retrive xml to structs
    //When you add a new repo. The hash id of the first commit is added as the newest commit to that repo.
        //this hash id is then updated to always represent the last commit?!?!?<--is this a good idea?
            //I think CommitDB should hold this index. yes!!!
    //loop through repos and get the last local commit
        //
    //loop through repos and check for new commits
        //insert new commits to CommitDB
    //on loop complete
        //populate CommitView w/ data from CommitDB

//Continue here, io works✅, db works✅,unwrap Dict works✅
    //make a plan for the next tasks: probably work with real data
        //You need to find all commits from the first until the hash stored in CommitDB
            //If no hash is stored in CommitDB for the repo
                //then the the range will be 0..commitCount
                //else range: 0..hash.from.CommitDB
        //make a test for this
        //then you store these commits to CommitDB, repoID is its index in repoList
        //then you try refreshing again, and check if the commits are read and stored correctly etc

//👉Update CommitDB on App Init👈
    //1. unwrap commitdb.xml
    //2. update CommitDB
        //loop over all repos
            //loop over all new commits
                //figure out which commits are new by using range 0..commitDB.prevCommits[repo-id].hash🚫
    //3. when commitDB refresh is complete
        //init app GUI🚀

//You don't need to store more commits than nessaccery in CommitDB 🚫
    //max 100 commits per repo
        //which means you need to store commits per repo after all
        //to remove the correct item from sortedByDates array
            //store the index of the location

//sortedByDate should actually pop of the last item if the count excedes a limit
    //
//The sortedByDate will have a date range (first..last)
    //this date range will be important to keep the array at max count 🔑 (when you add/remove new repos for instance)
    //when you loop commits 
        //only commits that are made after the last date in sortedByDate
            //make a git method that can find the hash of a commit nearest a data. 👈


//The new refresh commitDB algo🤖: (this refresh method needs to be acceccable from many places, so add it in CommitDBUtils.refresh())
    //You loop the repos
        //find the range of commits to add to CommitDB for this repo
        //if CommitDB.sortedByDates.count > 100
            //let lastDate = .count > 0 ? sortedByDates.last.date : Int.min<--min represents max negative num
            //range = now..lastDate in the repo (date based) Needs --> 🔬 (how does querrying for date ranges in git work)
            //let firstDate in range❌ <-- add this optimization later
            //find the index in sortedByDates❌<-- add this optimization later
            //(sortedByDates.count - index)❌<-- add this optimization later
        //else //< 100
            //let available = max - sortedByDates.count
            //range = 0..available (count based)
        //retrive the commit log items for this repo with the range speccified
        //add the commit log items to the CommitDB


//what happens if a commit was deleted? -> 
    //it stays in the CommitDb until its poped of the end (this is an edge case and could be dealt with later)
//what happens if a repo is removed from the app?
    //for loop sortedByDates and remove items matching the repo hash, do the same for prevCommit Dictionary
        //then run the refresh algo🤖 to repopulate the CommitList


//Continue here:
    //do the git date range research and tests
        //commit count after date ✅
        //format chronological date to git time-> "2016-11-12 00:00:00" ✅
        //then just grab the count range and wrap everything into nice method (make test first) ✅
    //make the refresh CommitDB algo🤖 as described
    //how do we refresh after commits and pushes to remote? 👉 after 👈 because -> simplicity 👌
