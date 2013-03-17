. helper.fish

function species
  fish species/reporter_quiet.fish
end

function it_returns_status_0
  species
  test $status -eq 0
end

function it_outputs_only_summary
  test (species | sed '/^$/d') = '3 examples, 0 failures'
end

. $fish_tank
