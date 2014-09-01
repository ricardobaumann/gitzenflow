#!/bin/sh
verify() {
	git show-ref --verify --quiet refs/heads/develop

	if [ $? -eq 1 ] ; then
		git checkout -B develop
	fi	
}


start() {
	verify()
	echo "Issue branch $1 will be created"
	git fetch && git checkout develop
	git checkout -B $1
}

push() {
	verify()
	git add -u . && git commit -m $3 && git push origin $2
}

pull() {
	verify()
	#echo "The changes of $2 will be pulled from remote repository"
	git pull origin $2
}

$@


