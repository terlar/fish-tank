. helper.fish

function species
  fish species/reporter_dots_with_error.fish
end

function spec_reporter_dots_with_error_1 -d 'returns status 1'
  species
  test $status -eq 1
end

function spec_reporter_dots_with_error_2 -d 'outputs colored dots'
  function expected
    echo -n (set_color red)F(set_color normal)
    echo -n (set_color green).(set_color normal)
    echo -n (set_color green).(set_color normal)
  end

  contains (expected) (species)
end

function spec_reporter_dots_with_error_3 -d 'outputs summary'
  function expected
    set_color red
    echo '3 examples, 1 failures'
    set_color normal
  end

  contains (expected) (species)
end

. $fish_tank
