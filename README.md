# fish-tank
The test framework for [fish](https://github.com/fish-shell/fish-shell),
write some tests and find out how they behave in the tank.

## Installation

```sh
git clone git://github.com/terlar/fish-tank.git
cd fish-tank
make install
```

## Configuration
For now there is only one piece of configuration:

`set -U tank_reporter dots` for simple output (default).

![tank_reporter dots](https://raw.github.com/terlar/fish-tank/master/doc/fish-tank_dots.png)

`set -U tank_reporter spec` for detailed output.

![tank_reporter spec](https://raw.github.com/terlar/fish-tank/master/doc/fish-tank_spec.png)

## Examples
A simple approach using a test helper.
It could be even simpler if you assume users have `fish-tank` installed, but it is good practice to make sure.
You could of course also skip the helper in simple cases, but it is recommended when having multiple tests to avoid duplication.

**helper.fish**
```sh
set -l fish_tank /usr/local/share/fish-tank/tank.fish
if not test -e $fish_tank
  echo 'error: fish-tank is required to run these tests (https://github.com/terlar/fish-tank)'
  exit 1
end

source (dirname (status -f))/../share/guppie/guppie.fish
```

**test_guppie.fish**
```sh
function suite_guppie
  function setup
    mkdir -p /tmp/guppie_tank
    stub_var guppie_count 1
  end

  function teardown
    rm -r /tmp/guppie_tank
  end

  function test_count
    assert_equal 1 (guppie --count)
    assert (guppie --add 4)
    assert_equal 5 (guppie --count)
  end

  function test_error
    refute (guppie --unknown)
  end

  function test_color
    assert_includes orange (guppie --colors)
  end
end


if not set -q tank_running
  source (dirname (status -f))/helper.fish
  tank_run
end
```
