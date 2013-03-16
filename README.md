# fish-tank
A small test framework for [fish](https://github.com/fish-shell/fish-shell) that helps you observe (run) and create speciments (specs) convenienly.

## Install

    git clone git://github.com/terlar/fish-tank.git
    cd fish-tank
    make install
    
## Configuration
For now there is only one piece of configuration:

`set -U tank_reporter dots` for simple output (default)

    fish guppie_spec.fish
      ...
    
`set -U tank_reporter spec` for detailed output

    fish guppie_spec.fish
      ✓ outputs "blubb blubb..."
      ✓ outputs returns status 0
      ✓ manipulates $guppie_count
    

## Examples
A simple approach using a test helper.

helper.fish

    set -xg fish_tank /usr/local/share/fish-tank/tank.fish
    if not test -e $fish_tank
      set -e fish_tank
      echo 'error: fish-tank is required to run these tests (https://github.com/terlar/fish-tank)'
      exit 1
    end

    . ../path/to/guppie.fish

    function setup_tank; return; end
    function clean_tank; return; end
    
guppie_spec.fish

    . helper.fish
    
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
    
    . $fish_tank
