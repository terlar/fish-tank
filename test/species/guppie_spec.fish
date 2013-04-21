function setup_tank
  set -g guppie_count 1
end

function clean_tank
  set -eg guppie_count
end

function it_outputs_blubb_blubb -d 'outputs "blubb blubb..."'
  test (guppie) = 'blubb blubb...'
end

function it_returns_status_0
  guppie
  test $status -eq 0
end

function it_manipulates_count -d 'manipulates $guppie_count'
  guppie
  test $guppie_count = 9000
end
