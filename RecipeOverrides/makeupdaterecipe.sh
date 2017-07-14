#!/bin/bash
#
#
set -x


plistbuddy="/usr/libexec/PlistBuddy"

groupname="App_%NAME%-update"
grouptemplate="SmartGroupUpdateTemplate.xml"
policytemplate="PolicyUpdateTemplate.xml"
category="_Updates"

name="$1"
recipe="$name".jss
recipe_update="$name"-update.jss
		
[ ! -f "$recipe_update.recipe" ] &&  autopkg make-override local.jss."$name" -n "$recipe_update"
		
$plistbuddy -c "Set :Input:GROUP_NAME $groupname" "$recipe_update.recipe"
$plistbuddy -c "Set :Input:GROUP_TEMPLATE $grouptemplate" "$recipe_update.recipe"
$plistbuddy -c "Set :Input:CATEGORY $category" "$recipe_update.recipe"
$plistbuddy -c "Set :Input:POLICY_CATEGORY $category" "$recipe_update.recipe"
$plistbuddy -c "Set :Input:POLICY_TEMPLATE $policytemplate" "$recipe_update.recipe"
        
autopkg run -vvvvvvv "$recipe_update.recipe"


exit 0
