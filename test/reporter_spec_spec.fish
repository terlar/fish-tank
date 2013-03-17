. helper.fish

function specimen
  fish specimens/reporter_spec.fish
end

function spec_reporter_spec_1 -d 'returns status 0'
  specimen
  test $status -eq 0
end

function spec_reporter_spec_2 -d 'outputs colored descriptions'
  function expected
    echo (set_color green)'  ✓ manipulates $guppie_count'
    set_color normal
    echo (set_color green)'  ✓ outputs "blubb blubb..."'
    set_color normal
    echo (set_color green)'  ✓ returns status 0'
    set_color normal
  end

  contains (expected) (specimen)
end

function spec_reporter_spec_3 -d 'outputs summary'
  contains '3 examples, 0 failures' (specimen)
end

. $fish_tank
