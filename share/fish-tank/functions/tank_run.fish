function tank_run
  set -l examples (__tank_suite)
  set -l failures
  set -l return_status 0

  for example in $examples
    functions -q setup_tank; and setup_tank

    eval "$example >/dev/null"
    set -l example_status $status

    __tank_reporter $example $example_status

    if test $example_status -gt 0
      set failures $failures $example
      set return_status 1
    end

    functions -q clean_tank; and clean_tank
  end

  __tank_summary (count $examples) (count $failures)
  return $return_status
end
