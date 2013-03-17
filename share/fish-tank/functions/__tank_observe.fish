function __tank_observe
  functions -q setup_tank; or function setup_tank; return; end;
  functions -q clean_tank; or function clean_tank; return; end;

  for example in $__tank
    setup_tank

    eval "$example >/dev/null"
    __tank_report $status $example

    clean_tank
  end

  echo

  set -l summary "$__tank_examples examples, $__tank_failures failures"

  if test $__tank_failures -eq 0
    echo $summary
  else
    set_color red
    echo $summary
    set_color normal
  end
end
