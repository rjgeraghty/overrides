#!/bin/bash
#
#

plistbuddy="/usr/libexec/PlistBuddy"

apps="Excel OneNote Outlook PowerPoint Word"
groupname="App_%NAME%-update"
grouptemplate="SmartGroupTemplate-update.xml"
policytemplate="PolicyTemplate-update.xml"
category="_Updates"
majorver="15"

for app in $apps; do
		recipe="Microsoft $app/Microsoft $app.jss"
		recipe_update="Microsoft $app/Microsoft $app-update.jss"
		
		[ ! -f "$recipe_update.recipe" ] &&  autopkg make-override "$recipe" -n "$recipe_update"
		
        $plistbuddy -c "Set :Input:GROUP_NAME $groupname" "$recipe_update.recipe"
        $plistbuddy -c "Set :Input:GROUP_TEMPLATE $grouptemplate" "$recipe_update.recipe"
        $plistbuddy -c "Set :Input:CATEGORY $category" "$recipe_update.recipe"
        $plistbuddy -c "Set :Input:POLICY_CATEGORY $category" "$recipe_update.recipe"
        $plistbuddy -c "Set :Input:POLICY_TEMPLATE $policytemplate" "$recipe_update.recipe"
        $plistbuddy -c "Add :Input:MAJOR_VERSION string $majorver" "$recipe_update.recipe"
        
        autopkg run -vvvvvvv "$recipe_update.recipe"
done


exit 0
