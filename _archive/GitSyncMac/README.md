![mit](https://img.shields.io/badge/License-MIT-brightgreen.svg) ![platform](https://img.shields.io/badge/Platform-macOS-blue.svg) ![Lang](https://img.shields.io/badge/Language-Swift-orange.svg) [![codebeat badge](https://codebeat.co/badges/5c7a5051-2fa6-45c1-9c2c-0db5fe70837b)](https://codebeat.co/projects/github-com-eonist-gitsyncosx) 


# GitSync
<img width="516" alt="img" src="https://raw.githubusercontent.com/stylekit/img/master/Element210-01.png">

**Commits:**

<img width="412" alt="img" src="https://raw.githubusercontent.com/stylekit/img/master/Screen Shot 2017-06-07 at 18.01.40.png">

**Prefs:** 

<img width="404" alt="img" src="https://raw.githubusercontent.com/stylekit/img/master/Screen Shot 2017-06-07 at 23.34.36.png">

**DarkMode:**	

<img width="412" alt="img" src="https://raw.githubusercontent.com/stylekit/img/master/Screen Shot 2017-06-07 at 17.49.33 copy.png">

## Install:

[Download](https://github.com/eonist/GitSync/releases) 

## Build:

1. Terminal: `cd ~/dev/GitSync/` 
2. Terminal: `swift package init` 
3. Copy/Paste the content of [Package.swift](https://github.com/eonist/Element/blob/master/Package.swift) to your newly created Package.swift file:
4. Terminal: `swift build` 
5. Terminal: `swift package generate-xcodeproj` 
6. XCode: open GitSync.xcodeproj and run it <kbd>Cmd</kbd>  <kbd>R</kbd>

## Change-log:
**2017-09-03**
- Added fast theme switching

**2017-09-02**
- Repository folders can now toggle all descendants 

**2017-09-01**
- - CheckBoxButton can now have mixed state

**2017-08-31**
- TextFields now have support for caret 
- AutoInitDialog now supports canceling
- Added support for replacing remote url in AutoInitDialog
- RepoDetailView now shows subset of UI when TreeItem is folder

**2017-08-28**
- Copy/paste/selectAll/undo now works in all TextFields

**2017-08-27**
- Notifications can be toggled per repo
- Save prefs and repo list to storage when switching view

**2017-08-26**
- Custom commit message now has ability cancel
- Added description to checkboxes
- Added ability to group UI components in the Unfold subsystem

**2017-08-16**
- Interval sync is now toggle-able per repo 
- Migrated Element, swift-utils and GitSyncMac to swift 4 and XCode 9

**2017-08-13**
- Fix Commit description having many newlines
- GitSync now Syncs on interval 

**2017-08-12**
- Refactored and cleaned up AutoSync and Refresh classes
- Added export/import repos feature

**2017-08-11**
- Fixed Stuck TextCursor in TextField
- Completed the AutoInitDialog

**2017-08-10**
- Added Logic to AutoInitView
- Created 4 Auto init Scenarios for the AutoInit process

**2017-08-09**
- Fixed TextField Enter/Exit Focus issue
- Added AutoInitView to resolve AutoInit conflicts

**2017-08-08**
- Added functionality to MergeConflict
- Added more UI types to UnfoldLib

**2017-08-07**
- Improved UnfoldLib in order to make Dialogs faster to setup
- Created the MergeConflict Dialog

**2017-08-06**
- Fixed a problem with pulling when there was no commits.
- Fixed the issue where commimtlist wouldn't update if CommitMessagePrompt had been shown

**2017-08-05**
- Fixed Commit items not showing in CommitView
- Made Element work with user agnostic paths (GitSync can now work by just downloading it)
- Added dev and prod Environment for debugging faster


