. helper.fish

function species
  fish species/reporter_dots_with_error.fish
end

function it_returns_status_1 -d 'returns status 1'
  species
  test $status -eq 1
end

function it_outputs_colored_dots -d 'outputs colored dots'
  function expected
    echo -n (set_color red)F(set_color normal)
    echo -n (set_color green).(set_color normal)
    echo -n (set_color green).(set_color normal)
  end

  contains (expected) (species)
end

function it_outputs_summary -d 'outputs summary'
  function expected
    set_color red
    echo '3 examples, 1 failures'
    set_color normal
  end

  contains (expected) (species)
end

. $fish_tank
