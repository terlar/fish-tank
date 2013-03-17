. helper.fish

function species
  fish species/reporter_dots.fish
end

function spec_reporter_dots_1 -d 'returns status 0'
  species
  test $status -eq 0
end

function spec_reporter_dots_2 -d 'outputs colored dots'
  function expected
    echo -n (set_color green).(set_color normal)
    echo -n (set_color green).(set_color normal)
    echo -n (set_color green).(set_color normal)
  end

  contains (expected) (species)
end

function spec_reporter_dots_3 -d 'outputs summary'
  contains '3 examples, 0 failures' (species)
end

. $fish_tank
