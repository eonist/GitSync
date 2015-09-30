//import utils/xml/XMLParser.swift
//import utils/misc/shell/ShellUtils.swift
//import utils/string/regexp/RegExpParser.swift
//import utils/string/regexp/RegExpModifier.swift

class GitSync{
	//Properties:
	let currentTime:Int = 0 //keeps track of the time passed, remember to reset this value pn every init
	let theInterval:Int = 60 //static value, increases the time by this value on every interval--TODO: rename to "frequncy"
	var repoList:Array = null //Stores all values the in repositories.xml, remember to reset this value pn every init
	let repoFilePath:String = ""
	let options = ["keep local version", "keep remote version", "keep mix of both versions", "open local version", "open remote version", "open mix of both versions", "keep all local versions", "keep all remote versions", "keep all local and remote versions", "open all local versions", "open all remote versions", "open all mixed versions"]
	var currentTime:Int = 0 //always reset this value on init, applescript has persistent values

	/*
	 * Handles the process of comitting, pushing for multiple repositories
	 * This is called on every interval
	 * NOTE: while testing you can call this manually, since idle will only work when you run it from an .app
	 */
	func handleInterval(){
		//print( "handle_interval()")
		repoList = RepoUtil.compileRepoList(repoFilePath) //try to avoid calling this on every intervall, its nice to be able to update on the fly, be carefull though
		let currentTimeInMin to (currentTime / 60) //divide the seconds by 60 seconds to get minutes
		//print ("currentTimeInMin: " + currentTimeInMin)
		for (repoItem in repoList){//iterate over every repo item
			if (currentTimeInMin % (repoItem["interval"]) = 0) { handleCommitInterval(repo_item, "master") } //is true every time spesified by the user
			if (currentTimeInMin % (repoItem["interval"]) = 0) { handlePushInterval(repo_item, "master") }//is true every time spesified by the user
		}
		current_time += theInterval //increment the interval (in seconds)
	}
	/*
	 * Handles the process of making a commit for a single repository
	 */
	func handleCommitInterval(repoItem, branch){
		//log "GitSync's handle_commit_interval() a repo with remote path: " & (remote_path of repo_item) & " local path: " & (local_path of repo_item)
		if (GitAsserter.hasUnmMergedPaths(repoItem["localPath"])) { //Asserts if there are unmerged paths that needs resolvment
			//log tab & "has unmerged paths to resolve"
			MergeUtil.resolveMergeConflicts(repoItem["localPath"], branch, GitParser.unMergedFiles(repoItem["localPath"])) //Asserts if there are unmerged paths that needs resolvment
		}
		do_commit(local_path of repo_item) //if there were no commits false will be returned
		//log "has_commited: " & has_commited
	}
	/*
	 * Handles the process of making a push for a single repository
	 * NOTE: We must always merge the remote branch into the local branch before we push our changes. 
	 * NOTE: this method performs a "manual pull" on every interval
	 * TODO: contemplate implimenting a fetch call after the pull call, to update the status, whats the diff between git fetch and git remote update again?
	 */
	func handlePushInterval(repo_item, branch){
		log ("GitSync's handle_push_interval()")
		my MergeUtil's manual_merge((local_path of repo_item), (remote_path of repo_item), branch) --commits, merges with promts, (this method also test if a merge is needed or not, and skips it if needed)
		set has_local_commits to GitAsserter's has_local_commits((local_path of repo_item), branch) --TODO: maybe use GitAsserter's is_local_branch_ahead instead of this line
		if (has_local_commits) then --only push if there are commits to be pushed, hence the has_commited flag, we check if there are commits to be pushed, so we dont uneccacerly push if there are no local commits to be pushed, we may set the commit interval and push interval differently so commits may stack up until its ready to be pushed, read more about this in the projects own FAQ
			set the_keychain_item_name to (keychain_item_name of repo_item)
			log "the_keychain_item_name: " & the_keychain_item_name
			set keychain_data to KeychainParser's keychain_data(keychain_item_name of repo_item)
			set keychain_password to the_password of keychain_data
			log "keychain_password: " & keychain_password
			set remote_account_name to account_name of keychain_data
			log "remote_account_name: " & remote_account_name
			set push_call_back to GitModifier's push(local_path of repo_item, remote_path of repo_item, remote_account_name, keychain_password, branch)
			log "push_call_back: " & push_call_back
		end if
	}
}

class RepoUtils{//Utility methods for parsing the repository.xml file
	/**
	 * Returns a list with repo values derived from an XML file
 	 * @param file_path 
 	 * TODO: if the interval values is not set, then use default values
	 * TODO: test if the full/partly file path still works?
	 */
	func compileRepoList(filePath:String)->Array{
		let xml:String = XMLParser.data(filePath)
		let children:Array = xml["."]["repositories"][0]["."]["repository"]
		let numChildren:Int = children.count //number of xml children in xml root element
		var theRepoList:Array to []
		for (var i:Int; i++; i < numChildren){
			let child = children[i]
			let localPath to child["@"]["local-path"] //this is the path to the local repository (we need to be in this path to execute git commands on this repo)
			let localPath = ShellUtils.run("echo " + "'" + localPath + "'" + " | sed 's/ /\\\\ /g'")//--Shell doesnt handle file paths with space chars very well. So all space chars are replaced with a backslash and space, so that shell can read the paths. 
			let remotePath: String = child["@"]["remote_path"]
			remotePath = RegExpModifier.replace(remotePath,"^https://.+$","")//support for partial and full url, strip away the https://, since this will be added later
			//print(remotePath)
			let keychainItemName: String = child["@"]["keychain-item-name"]
			let interval: String = child["@"]["interval"]//default is 1min
			let remoteAccountName: String = child["@"]["remote-account-name"]
			theRepoList += ["localPath":localPath,"remotePath":remotePath,"keychainItemName":keychainItemName,"interval":interval,"remoteAccountName":remoteAccountName]
		}
		return theRepoList
	}
}

class MergeUtils{
	/*
 	 * Promts the user with a list of options to aid in resolving merge conflicts
 	 * @param branch: the branch you tried to merge into
 	 */
	on resolveMergeConflicts(localRepoPath, branch, unMergedFiles)
		//log "resolve_merge_conflicts()"
		//log ("MergeUtil's resolve_merge_conflicts()")
		for( unMergedFile in unMergedFiles){;
			set lastSelectedAction to first item in options //you may want to make this a "property" to store the last item more permenantly
			set theAction to choose from list options with title "Resolve merge conflict in:" with prompt unMergedFile & ":" default items {lastSelectedAction} cancel button name "Exit" //promt user with list of options, title: Merge conflict in: unmerged_file
			handle_merge_conflict_dialog(the_action, unMergedFile, localRepoPath, branch, unMergedFiles)
		}
	end resolve_merge_conflicts
}












