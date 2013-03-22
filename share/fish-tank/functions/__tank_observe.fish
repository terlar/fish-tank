function __tank_observe
  functions -q setup_tank; or function setup_tank; end;
  functions -q clean_tank; or function clean_tank; end;

  for example in $__tank_examples
    setup_tank

    eval "$example >/dev/null"
    __tank_report $status $example

    clean_tank
  end

  echo

  set -l examples (count $__tank_examples)
  set -l failures (count $__tank_failures)

  set -l summary "$examples examples, $failures failures"

  if test $failures -eq 0
    echo $summary
    return 0
  else
    set_color red
    echo $summary
    set_color normal
    return 1
  end
end
