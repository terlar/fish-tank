set -g tank_reporter quiet

function guppie
  echo 'blubb blubb...'
  set guppie_count 9000
end

. (dirname (status -f))/guppie_spec.fish
. (dirname (status -f))/../../share/fish-tank/tank.fish
