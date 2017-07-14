#!/bin/bash
#
#
set -x

plistbuddy="/usr/libexec/PlistBuddy"

apps="Excel OneNote Outlook PowerPoint Word"
groupname=" "
grouptemplate=" "
policytemplate="PolicyTemplate.xml"
category="Productivity"

for app in $apps; do
		recipe="Microsoft $app/Microsoft $app.jss.recipe"
		
        $plistbuddy -c "Set :Input:GROUP_NAME $groupname" "$recipe" 
        $plistbuddy -c "Set :Input:GROUP_TEMPLATE $grouptemplate" "$recipe" 
        $plistbuddy -c "Set :Input:CATEGORY $category" "$recipe" 
        $plistbuddy -c "Set :Input:POLICY_CATEGORY $category" "$recipe" 
        $plistbuddy -c "Set :Input:POLICY_TEMPLATE $policytemplate" "$recipe" 
        
        autopkg run -vvvvvvv "$recipe" 
done



exit 0
