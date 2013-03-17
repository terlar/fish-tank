function __tank_reporter_dots
  if test $argv[1] -eq 0
    set_color green
    echo -n .
  else
    set_color red
    echo -n F
  end

  set_color normal
end
