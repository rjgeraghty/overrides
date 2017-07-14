#!/bin/bash
#
#

set -x

recipe="$1"
category="Testing"

[ ! -z "$2" ] && category="$2"

plistbuddy="/usr/libexec/PlistBuddy"

$plistbuddy -c "Set :Input:GROUP_NAME " "$recipe"
$plistbuddy -c "Set :Input:GROUP_TEMPLATE " "$recipe"
$plistbuddy -c "Set :Input:CATEGORY $category" "$recipe"
$plistbuddy -c "Set :Input:POLICY_CATEGORY $category" "$recipe"
$plistbuddy -c "Add :Input:pkg_path string " "$recipe"


exit 0

