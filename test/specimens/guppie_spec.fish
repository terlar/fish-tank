function setup_tank
  set -xg guppie_count 1
end

function clean_tank
  set -e guppie_count
end

function spec_guppie_outputs -d 'outputs "blubb blubb..."'
  test (guppie) = 'blubb blubb...'
end

function spec_guppie_returns -d 'returns status 0'
  guppie
  test $status -eq 0
end

function spec_guppie_manipulates_count -d 'manipulates $guppie_count'
  guppie
  test $guppie_count = 9000
end
