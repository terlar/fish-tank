. helper.fish

function specimen
  fish specimens/reporter_dots.fish
end

function spec_reporter_dots_1 -d 'returns status 0'
  specimen
  test $status -eq 0
end

function spec_reporter_dots_2 -d 'outputs colored dots'
  function expected
    echo -n (set_color green).(set_color normal)
    echo -n (set_color green).(set_color normal)
    echo -n (set_color green).(set_color normal)
  end

  contains (expected) (specimen)
end

function spec_reporter_dots_3 -d 'outputs summary'
  contains '3 examples, 0 failures' (specimen)
end

. $fish_tank
