. (dirname (status -f))/helper.fish

function species
  fish $species_path/reporter_dots.fish
end

function it_returns_status_0
  species
  test $status -eq 0
end

function it_outputs_colored_dots
  function expected
    echo -n (set_color green).(set_color normal)
    echo -n (set_color green).(set_color normal)
    echo -n (set_color green).(set_color normal)
  end

  contains (expected) (species)
end

function it_outputs_summary
  contains '3 examples, 0 failures' (species)
end

. $fish_tank
