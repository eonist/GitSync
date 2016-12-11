//Continue here:
    //Brush up on your Git Skills. 
    //Publish 4 articles about Git on gitsync.io
    //Take a look at how the GitSync apple-script is organized. and copy the workflow to swift (Next)
    //Figure out how to derive previous commit messages from repo's. You need from 0 to 50 latest commits.
        //Then figure out how to sort these based on the date within them
        //Then make a list of all commits from all repos. Cap the list at 500
        //then add this list to CommitsView
        //Figure out how you can update the FastList with new Items and not lose track of selected idx etc
            //Start testing this with the regular List
                //I think you can just append the DataProvider and refresh the visible items, then you just increment the selected idx for every append
    //create the new Add and remove buttons that are bright blue so that they gathers the attention needed
    
//Completed:
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
//Later
    //path picker for localPath in repodetailview (folder icon)
    //add a eye-icon for find in finder feature in repodetailview
    //write about the mc2/bump idea (create logo idea ?!?)
    //prepare 3 blog posts about FastList,ProgressIndicator,LineGraph for stylekit
    //attempt to add the switch skin functionality in a small isolated test (w/ styles from generic.css, just switching a few params)
    //Use the san-fran font (if you can find it)
    
//Future
    //Animate the Menu Icons to wobble in and out on click (similar to twitter for iOS)
    //cmd click on repo items will reveal edit icon in top bar for multi edit feature