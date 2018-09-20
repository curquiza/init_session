set fish_git_dirty_color red
set fish_git_not_dirty_color green

function parse_git_branch
	set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
	set -l git_status (git status -s)

	printf "%s " $branch
	if test -n "$git_status"
		printf "%s" (set_color $fish_git_dirty_color)'✗'
	else
		printf "%s" (set_color $fish_git_not_dirty_color)'✔'
	end
	set_color normal
end

function fish_right_prompt -d "Write out the right prompt"
	set -l git_dir (git rev-parse --git-dir 2> /dev/null)

	if test -n "$git_dir"
		printf "%s  %s" (parse_git_branch) (set_color normal)
	end
	date '+%d/%m/%y %H:%M'
end
