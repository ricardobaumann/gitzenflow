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
	git add .
	git commit -m $2
	git push origin $3
}

pull() {
	git pull origin $2
}

$@


