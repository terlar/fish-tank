. helper.fish

function species
  fish species/reporter_spec_with_error.fish
end

function it_returns_status_1 -d 'returns status 1'
  species
  test $status -eq 1
end

function it_outputs_colored_description -d 'outputs colored descriptions'
  function expected
    echo (set_color red)'  ✗ manipulates $guppie_count'
    set_color normal
    echo (set_color green)'  ✓ outputs "blubb blubb..."'
    set_color normal
    echo (set_color green)'  ✓ returns status 0'
    set_color normal
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
