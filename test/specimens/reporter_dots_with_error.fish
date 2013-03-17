set -xg tank_reporter dots

function guppie
  echo 'blubb blubb...'
end

. (dirname (status -f))/guppie_spec.fish
. (dirname (status -f))/../../share/fish-tank/tank.fish
