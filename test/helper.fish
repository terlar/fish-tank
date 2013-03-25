set -xg fish_tank (dirname (status -f))/../share/fish-tank/tank.fish
set -xg species_path (dirname (status -f))/species

function setup_tank; end
function clean_tank; end
