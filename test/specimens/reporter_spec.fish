set -xg tank_reporter spec

function guppie
  echo 'blubb blubb...'
  set guppie_count 9000
end

. (dirname (status -f))/guppie_spec.fish
. (dirname (status -f))/../../share/fish-tank/tank.fish
