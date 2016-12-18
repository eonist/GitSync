### Continue here:
    //Fix the CompactBody problem (occurs with Element MacOS repo) (Next)
    //Figure out a workflow to store commit logs in xml (maybe use reflection) because querying git is cpu intensive
        //you need to be able to easily extract commits based on date. 
            //so storing the same amount as the max visible amount is important
            //when you hit refresh you only gather commits that are not in DP (use first Hash from existing commits and first hash from repo to get the range you need)
                //This requires a standalone test to get right
            //When you add a Repo to the address-book you also load max visible commits to DP
            //dp.getItemsByKey("repo-id")
            //you need to create a custom CommitDB extends DataProvider with data-model: (Dict->Array->Dict)
                //Stores commits by key: "repo-id" (repo-id is a unique incremental global id)
            //you also need to store a ref in an Array that stores all commits sorted by date (latest to oldest) (you insert commits by finding its index by halving the array until you find the right index)
                //Do an experiment to figure out the halving technique (Binary search)
                //you then slice CommitDB.sortedByDate from 0 until maxVisibleCommits (100) and use this array for the ListView
                    //this will give you a chronologically sorted commit list (descending)
                    
                //you then need to figure out how to update this sorted list on refresh (next)
                    //you could keep a DP instance for ListView that you prepend new items onto
                        //you compare the two lists by getting the first of ListView.dp and the first of ComitDB.sortedByDate.slice(0,100)
                
    //Maybe use a simpler list while debugging and a non-fancy refresh button (to test out ideas and the GitSync algorithm)
    //Create the new Add and remove buttons that are bright blue so that they gathers the attention needed
    //Take a look at how the GitSync apple-script is organized. and copy the workflow to swift 
    //Improve the compact-date parser (see twitter app and also other apps)
    //Translucent overlay for the menu 
### Completed:
    //Figure out how to derive previous commit messages from repo's. You need from 0 to 10 latest commits.
        //Research custom "git log" commands (done)
        //Store each commit in an array with data capsules (date:"",author:"",subject:"",body:"") (DONE)
            //figure out the body bug by printing all the body strings and testing each one (done)
                //also cap the subject? or maybe not? maybe there is a max subject length already? google it (done 50/72 rule)
            //store all subjects and body strings in a txt file for debugging (done, used GitHub Desktop)
        //Format the date into an NSDate instance, see old notes (Done)
        //Then figure out how to sort these based on the date within them (Done)
            //make an array with Tuples then sort on date as num: 20161203 aka YYYYMMDDHHMMSS (Done)
        //Then make a list of all commits from all repos. Cap the list at 200 divide by repos.count to find how many to get from each repo
            //Use NSNotification with NSTask when extracting data from the repos (done)
                //try to add the task to a Background thread
        //then add this list to CommitsView (done)
    //Write a post about Gitsync app demo (done)
    //Brush up on your Git Skills. (done)
    //Publish 4 articles about Git on gitsync.io (done)
    //setup init test for the GitSync Algo with a few test projects (see old test files) (done)
    //make the textBg in the darkmode more subtle, its too bright at the moment (done)
    //create the 10 sec video demo of the Current GUI interactions (done)
    //add the Date Text UI Element to StatsView and hock up the interactivity logic (next)
        //move the DateText into the CommitGraph, because touch interactivity is located there
    //RepoDetailView should have a CheckBoxButton: Auto-sync (done)
    //PrefsView should have the Auto-sync-interval: (as its too complicated to have individual timers, too much can go wrong) (done)
    //move sync interval to prefs-view (done)
    //create auto-sync checkbox in repo-detail-view (done)
    //rename subscribe and broadcast to download and upload (done)
    //darkmode checkbox should be true (done)
    //design CommitDetailView in illustrator (done)
    //adjust the dialog designs (done)
    //add CommitDetailView to the app (take cues from GitHub) (done)
    //Create the Conflict resolution prompt w/ darkmode (done)
    //Create the commit message prompt w/ darkmode (done)
    //center-align repo-detail and add broader text input fields (done)
    //center-align the prefs (done)
### Later
    //Figure out how you can update the FastList with new Items and not lose track of selected idx etc
        //Start testing this with the regular List
        //I think you can just append the DataProvider and refresh the visible items, then you just increment the selected idx for every append
    //path picker for localPath in repodetailview (folder icon)
    //add a eye-icon for find in finder feature in repodetailview
    //write about the mc2/bump idea (create logo idea ?!?)
    //prepare 3 blog posts about FastList,ProgressIndicator,LineGraph for stylekit
    //attempt to add the switch skin functionality in a small isolated test (w/ styles from generic.css, just switching a few params)
    //Use the san-fran font (if you can find it)
    
### Future
    //Animate the Menu Icons to wobble in and out on click (similar to twitter for iOS)
        //Make animated gif of this animation in double retina resolution
    //cmd click on repo items will reveal edit icon in top bar for multi edit feature
    //Add support for tabbing the textfields
    //Add focus state support to the TextInput components