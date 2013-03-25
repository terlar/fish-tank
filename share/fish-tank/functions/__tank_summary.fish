function __tank_summary
  echo
  set -l summary "$argv[1] examples, $argv[2] failures"

  if test $argv[2] -eq 0
    echo $summary
  else
    set_color red
    echo $summary
    set_color normal
  end
end
