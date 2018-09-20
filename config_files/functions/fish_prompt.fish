function fish_prompt
	set -l exit_code $status

	printf "%s %s%s%s" (whoami) (set_color yellow) (prompt_pwd) (set_color normal)

	if test $exit_code -ne 0
		set_color red
		printf "  T.T > "
	else
		set_color green
		printf "  ^.^ > "
	end
	set_color normal
end
