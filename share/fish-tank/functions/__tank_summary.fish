function __tank_summary
  set -l summary "$argv[1] examples, $argv[2] failures"
  echo

  if test $argv[2] -eq 0
    echo $summary
  else
    set_color red
    echo $summary
    set_color normal
  end
end
