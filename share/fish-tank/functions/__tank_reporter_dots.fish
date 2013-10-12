function __tank_reporter_dots
  function __tank_report_start
    echo
    echo '# Running:'
    echo
  end

  function __tank_report_progress
    if test $argv = 0
      echo -n '.'
    else
      echo -n 'F'
    end
  end

  function __tank_report_finish
    echo
    __tank_report_stats
    __tank_report_results
    __tank_report_summary
  end
end
