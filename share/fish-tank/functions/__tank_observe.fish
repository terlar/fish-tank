function __tank_observe
  functions -q setup_tank; or function setup_tank; return; end;
  functions -q clean_tank; or function clean_tank; return; end;

  for spec in $__tank_species
    setup_tank

    eval "$spec >/dev/null"
    __tank_report $status $spec

    clean_tank
  end

  echo

  set -l summary "$__tank_species_total examples, $__tank_species_failed failures"

  if test $__tank_species_failed -eq 0
    echo $summary
  else
    set_color red
    echo $summary
    set_color normal
  end
end
