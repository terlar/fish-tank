. helper.fish

function species
  fish species/reporter_dots.fish
end

function it_returns_status_0 -d 'returns status 0'
  species
  test $status -eq 0
end

function it_outputs_colored_dots -d 'outputs colored dots'
  function expected
    echo -n (set_color green).(set_color normal)
    echo -n (set_color green).(set_color normal)
    echo -n (set_color green).(set_color normal)
  end

  contains (expected) (species)
end

function it_outputs_summary -d 'outputs summary'
  contains '3 examples, 0 failures' (species)
end

. $fish_tank
