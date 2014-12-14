function __tank_run_tests
	set -l tests (begin
		functions -n | grep test_
		eval $argv >/dev/null
		functions -n | grep test_
	end | sort | uniq -u | shuf)

	for test in $tests
		emit test_run $test
		eval $test
		emit test_finished $test
	end
end

# Events
function __tank_test_setup -e test_run
	set -g __tank_current_test $argv
	set -g __tank_current_test_status success
	functions -q setup; and setup
end

function __tank_test_teardown -e test_finished
	functions -q teardown; and teardown
	functions -e $argv
	set -e __tank_current_test_skip

	switch $__tank_current_test_status
		case success
			emit test_success
		case failure
			emit test_failure
		case error
			emit test_error
		case skip
			# skip
	end
end

function __tank_test_skip_assertions -e test_skip -e test_stop
	set -g __tank_current_test_skip 1
end
