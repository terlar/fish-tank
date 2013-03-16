# fish-tank
A small test framework for [fish](https://github.com/fish-shell/fish-shell) that helps you create speciments (specs) and observe (run) them in the tank.

## Install

    git clone git://github.com/terlar/fish-tank.git
    cd fish-tank
    make install

## Configuration
For now there is only one piece of configuration:

`set -U tank_reporter dots` for simple output (default)

![tank_reporter dots](https://raw.github.com/terlar/fish-tank/master/doc/fish-tank_dots.png)

`set -U tank_reporter spec` for detailed output

![tank_reporter spec](https://raw.github.com/terlar/fish-tank/master/doc/fish-tank_spec.png)

## Examples
A simple approach using a test helper. Could be even simpler if you assume users have fish-tank installed, but it is good practice to make sure.

**helper.fish**

    set -xg fish_tank /usr/local/share/fish-tank/tank.fish
    if not test -e $fish_tank
      set -e fish_tank
      echo 'error: fish-tank is required to run these tests (https://github.com/terlar/fish-tank)'
      exit 1
    end

    . ../path/to/guppie.fish

    function setup_tank; return; end
    function clean_tank; return; end

**guppie_spec.fish**

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
