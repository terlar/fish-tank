# Fish Tank
set -l tank_path (dirname (status -f))

if not contains $tank_path/functions $fish_function_path
	set fish_function_path $tank_path/functions $fish_function_path
end

if not type -t source >/dev/null
	function source
		. $argv
	end
end

for feature in $tank_path/features/*.fish
	source $feature
end
