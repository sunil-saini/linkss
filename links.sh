#!/usr/bin/env bash

source "$HOME/.linkss/.links"

showHelp() {
    echo """
linkss()

NAME
    linkss -

DESCRIPTION
    Command Line Tool to add urls as shell command

SYNOPSIS
    linkss [options]

OPTIONS
    -h, --help
        show help
    -l  --list
        list existing commands
    -a  --add
        add/modify existing commands
    -d  --delete
        delete existing command
"""
}

showList () {
    emptyFile
    if [ "$?" -eq 0 ]; then
        return
    fi
    while read line; do
        echo "$line" | awk -F',' '{print $2 " --> " $1}'
    done <"$HOME/.linkss/links.txt"
}

function emptyFile() {
    if [ ! -s "$HOME/.linkss/links.txt" ]; then
        echo "no saved urls"
        return 0
    fi
    return 1
}

delLink() {

    emptyFile
    if [ "$?" -eq 0 ]; then
        return
    fi
    read -p "Enter url : " url
	while [[ "$url" == "" ]]
	do
		read -p "Enter url : " url
	done
    grep -v "^$url," "$HOME/.linkss/links.txt" > _tempLinks
    mv _tempLinks "$HOME/.linkss/links.txt"
    grep -v "{ open \"$url\"; }$" "$HOME/.linkss/.links" > _tempCommands
    mv _tempCommands "$HOME/.linkss/.links"
    echo "url $url removed successfully"
}

linkss () {

    if [ "$#" -ne 1 ]; then
        showHelp
        return
    else
        case "$1" in
        -h|--help)
            showHelp  
            return
            ;;
        -l|--list)
            showList
            return
            ;;
        -a|--add)
            ;;
        -d|--delete)
            delLink
            return
            ;;
        *)
            echo "unsupported option $1"
            showHelp  
            return
            ;;
        esac
    fi

    linksTxtPath="$HOME/.linkss/links.txt"
    linksCommandsPath="$HOME/.linkss/.links"

	echo "Enter url and short name"
	read -p "Enter url : " url
	while [[ "$url" == "" ]]
	do
		read -p "Enter url : " url
	done
	
	inpuSuffix=""
	currsName=""
	matchLine=`grep "^$url," "$linksTxtPath"`
	if [[ "$matchLine" != "" ]]
	then
		currsName=`echo $matchLine | awk -F"," '{print $2}'`
		inpuSuffix="[current=$currsName] "
	fi

	read -p "Enter short name for url $inpuSuffix: " sName
	while [[ "$sName" == "" ]] && [[ "$currsName" == "" ]]
	do
		read -p "Enter short name for url $inpuSuffix: " sName
	done

	# previous name & current name are different
    if [[ "$sName" != "$currsName" ]]
	then
        newLine="$url,$sName"
        # previous name is not empty
        if [[ "$currsName" != "" ]]
        then
            # no new name provided
            if [[ "$sName" == "" ]]; then
                return
            fi
            grep -v "^$url," "$linksTxtPath" > _tempLinks
            mv _tempLinks "$linksTxtPath"
            grep -v "^$currsName ()" "$linksCommandsPath" > _tempCommands
            mv _tempCommands "$linksCommandsPath"
            action="updated"
        else
            action="added"
        fi
        echo "$newLine" >> "$linksTxtPath"
        echo "$sName () { open \"$url\"; }" >> "$linksCommandsPath"
        echo "for url $url command $sName $action successfully"
	fi
}
