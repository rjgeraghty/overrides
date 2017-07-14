#!/bin/bash
#
#

plistbuddy="/usr/libexec/PlistBuddy"

apps="Excel OneNote Outlook PowerPoint Word"
category="Productivity"

for app in $apps; do
        autopkg make-override "Microsoft $app.jss"
        $plistbuddy -c "Set :Input:GROUP_NAME App_%NAME%-update-smart" "Microsoft $app.jss.recipe"
        $plistbuddy -c "Set :Input:CATEGORY $category" "Microsoft $app.jss.recipe"
        $plistbuddy -c "Set :Input:POLICY_CATEGORY $category" "Microsoft $app.jss.recipe"
        autopkg run -vvvv "Microsoft $app.jss.recipe"
done

exit 0

