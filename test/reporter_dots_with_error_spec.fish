. (dirname (status -f))/helper.fish

function species
  fish $species_path/reporter_dots_with_error.fish
end

function it_returns_status_1
  species
  test $status -eq 1
end

function it_outputs_colored_dots
  function expected
    echo -n (set_color red)F(set_color normal)
    echo -n (set_color green).(set_color normal)
    echo -n (set_color green).(set_color normal)
  end

  contains (expected) (species)
end

function it_outputs_summary
  function expected
    set_color red
    echo '3 examples, 1 failures'
    set_color normal
  end

  contains (expected) (species)
end

. $fish_tank
