function __tank_report_stats
  echo
  echo "Finished in "$__tank_total_time"s"
end

function __tank_report_results
  test $__tank_failures -eq 0; and return

  set -l result_count (count $__tank_results)
  for count in (seq 1 $result_count)
    echo
    echo "  $count) Failure:"
    echo "$__tank_results_label[$count]:"
    echo $__tank_results[$count]
  end
end

function __tank_report_summary
  echo
  echo -n $__tank_count' runs, '
  echo -n $__tank_assertions' assertions, '
  echo -n $__tank_failures' failures, '
  echo -n $__tank_errors' errors, '
  echo $__tank_skips' skips'
end

# Utils
function time_diff
  test (count $argv) = 2; or return 1
  which bc >/dev/null ^/dev/null; or return 1
  set -l start $argv[1]
  set -l end $argv[2]
  set -l diff (expr $end - $start)
  printf '%g' (echo "scale=3;$diff/1000"|bc)
end

# Events
function __tank_report_setup -e tank_run
  set -g __tank_assertions 0
  set -g __tank_count 0
  set -g __tank_errors 0
  set -g __tank_skips 0
  set -g __tank_failures 0

  set -g __tank_results
  set -g __tank_results_label

  set -l reporter "__tank_reporter_$tank_reporter"
  if not functions -q $reporter
    set reporter __tank_reporter_dots
  end
  eval $reporter

  __tank_report_start
  set -g __tank_start_time (date '+%s%N'|cut -b1-13)
end

function __tank_report_teardown -e tank_finished
  set -g __tank_total_time (time_diff $__tank_start_time (date '+%s%N'|cut -b1-13))
  __tank_report_finish
end


function __tank_report_test_success -e test_success
  __tank_report_progress 0
end
function __tank_report_test_failure -e test_failure
  __tank_report_progress 1
end

function __tank_report_test_run -e test_run
  set __tank_count (expr $__tank_count + 1)
end
function __tank_report_test_skip -e test_skip
  set __tank_skips (expr $__tank_skips + 1)
end
function __tank_report_test_error -e test_error
  set __tank_errors (expr $__tank_errors + 1)
end

function __tank_report_assertion -e assertion_success -e assertion_failure
  set __tank_assertions (expr $__tank_assertions + 1)
end
function __tank_report_assertion_failure -e assertion_failure
  set __tank_failures (expr $__tank_failures + 1)
  set __tank_results $__tank_results $argv
  set __tank_results_label $__tank_results_label $__tank_current_suite'#'$__tank_current_test
end
