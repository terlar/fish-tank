function tank_run
	set -q tank_running; and return
	set -g tank_running 1

	if test (count $argv) -gt 0
		for file in $argv
				source $file
		end
	end

	tank_run_suite (functions -q | grep suite_)
end
