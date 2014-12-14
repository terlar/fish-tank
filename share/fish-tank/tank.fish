# Fish Tank
set -l tank_path (dirname (status -f))

if not contains $tank_path/functions $fish_function_path
	set fish_function_path $tank_path/functions $fish_function_path
end

if not type -q source
	function source
		. $argv
	end
end

if not type -q shuf
	function shuf
		cat /dev/stdin \
			| awk 'BEGIN{srand()}{printf "%06d %s\n", rand()*1000000, $0;}' \
			| sort -n \
			| cut -c8-
	end
end

for feature in $tank_path/features/*.fish
	source $feature
end
