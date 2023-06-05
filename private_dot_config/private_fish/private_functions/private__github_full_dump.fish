function _github_full_dump
	set repos (gh ls -L 227 --visibility public | awk '{ print $1 }')
	for i in $repos
		gcl $i
	end
end
