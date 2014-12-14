function stub
	set -l target $argv[1]
	set -l stub $argv[2]
	set -g __tank_stubs $__tank_stubs $target

	if functions -q $target
		if not functions -q __tank_stubs_backup_$target
			functions -c $target __tank_stubs_backup_$target
		end
		functions -e $target
	end

	functions -c $stub $target
	functions -e $stub
end

function unstub
	set -l target $argv[1]

	functions -e $target

	if functions -q __tank_stubs_backup_$target
		functions -c __tank_stubs_backup_$target $target
		functions -e __tank_stubs_backup_$target
	end
end

function stub_var
	set -l target $argv[1]
	set -l stub $argv[2..-1]

	set -g __tank_var_stubs $__tank_var_stubs $target

	if not set -q __tank_var_stubs_backup_$target
		set -g __tank_var_stubs_backup_$target $$target
	end

	if set -q $target
		set $target $stub
	else
		set -g $target $stub
	end
end

function unstub_var
	set -l target $argv[1]
	set -l backup __tank_var_stubs_backup_$target

	set $target $$backup
	set -e $backup
end

# Events
function __tank_test_stub_teardown -e test_finished -e test_unstub
	for target in $__tank_stubs
		unstub $target
	end
	set -e __tank_stubs

	for target in $__tank_var_stubs
		unstub_var $target
	end
	set -e __tank_var_stubs
end
