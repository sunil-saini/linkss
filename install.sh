#!/usr/bin/env bash

projPATH="$HOME/.linkss"
bashProfilePath="$HOME/.bash_profile"

mkdir "$projPATH"
touch "$projPATH/.links" "$projPATH/links.txt"

curl https://raw.githubusercontent.com/sunil-saini/linkss/main/links.sh -o "$projPATH/links.sh"

linksSourceLins="source $projPATH/links.sh"
if grep -Fxq "$linksSourceLins" "$bashProfilePath"
then
	echo "$projPATH/links.sh already added for source in $bashProfilePath"
else
	echo "$projPATH/links.sh source line added in $bashProfilePath"
    echo """
# added by linkss
$linksSourceLins
""" >> "$bashProfilePath"
fi
