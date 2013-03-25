. (dirname (status -f))/helper.fish

function species
  fish $species_path/reporter_spec.fish
end

function it_returns_status_0
  species
  test $status -eq 0
end

function it_outputs_colored_descriptions
  function expected
    echo (set_color green)'  ✓ manipulates $guppie_count'
    set_color normal
    echo (set_color green)'  ✓ outputs "blubb blubb..."'
    set_color normal
    echo (set_color green)'  ✓ returns status 0'
    set_color normal
  end

  contains (expected) (species)
end

function it_outputs_summary
  contains '3 examples, 0 failures' (species)
end

. $fish_tank
