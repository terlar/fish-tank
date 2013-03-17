. helper.fish

function species
  fish species/reporter_quiet.fish
end

function spec_reporter_quiet_1 -d 'returns status 0'
  species
  test $status -eq 0
end

function spec_reporter_quiet_2 -d 'outputs only summary'
  test (species | sed '/^$/d') = '3 examples, 0 failures'
end

. $fish_tank
