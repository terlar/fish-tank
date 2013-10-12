function __tank_reporter_spec
  function __tank_report_start
    echo
    echo '# Running:'
  end

  function __tank_report_progress
    set -l suite $__tank_current_suite
    if not test "$suite" = "$__tank_progress_report_suite"
      set -g __tank_progress_report_suite $suite
      echo
      echo $suite
    end

    if test $argv = 0
      set_color green
      echo -n '  ✓ '
    else
      set_color red
      echo -n '  ✗ '
    end

    echo $__tank_current_test
    set_color normal
  end

  function __tank_report_finish
    __tank_report_stats
    __tank_report_results
    __tank_report_summary
  end
end
