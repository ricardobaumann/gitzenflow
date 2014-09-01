#!/bin/sh
verify() {
	git show-ref --verify --quiet refs/heads/develop

	if [ $? -eq 1 ] ; then
		echo "Branch Develop will be created"
		git checkout -B develop
	else
		echo "Branch Develop already exists"
	fi	

	git config credential.helper cache && git config credential.helper 'cache --timeout=30000000'
}


start() {
	if [ -z "$1" ]
	  then
	    echo "The issue branch name must be informed. Use zf-issue start <issue>"
	    exit 1
	fi
	verify
	git fetch && git checkout develop
	git checkout -B $1
}

push() {
	if [ -z "$1" ] || [ -z "$2" ]
	  then
	    echo "The issue branch name and the commit message must be informed. Use zf-issue push <issue> <message>"
	    exit 1
	fi
	git add -A .
	git commit -m $2
	git push origin $1
}

pull() {
	if [ -z "$1" ]
	  then
	    echo "The issue branch name must be informed. Use zf-issue pull <issue>"
	    exit 1
	fi
	git pull origin $2
}

$@


