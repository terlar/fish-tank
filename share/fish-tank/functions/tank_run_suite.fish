function tank_run_suite
  emit tank_run
  for suite in $argv
    emit suite_run $suite
    __tank_run_tests $suite
    emit suite_finished $suite
  end
  emit tank_finished

  return (test $__tank_failures -eq 0)
end

# Events
function __tank_suite_setup -e suite_run
  set -g __tank_current_suite $argv
end

function __tank_suite_teardown -e suite_finished
  functions -e setup
  functions -e teardown
  functions -e $argv
end
