#!/bin/sh
verify() {
	git show-ref --verify --quiet refs/heads/develop

	if [ $? -eq 1 ] ; then
		echo "tilt"
		git checkout -B develop
	else
		echo "not tilt"
	fi	
}


start() {
	verify
	git fetch && git checkout develop
	git checkout -B $1
}

push() {
	verify
	git add .
	git commit -m $1
}

pull() {
	verify()
	#echo "The changes of $2 will be pulled from remote repository"
	git pull origin $2
}

$@


