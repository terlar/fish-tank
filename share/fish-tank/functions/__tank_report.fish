function __tank_report
  set -l example_status $argv[1]
  set -l example_description (__tank_example_description $argv[2])
  set -l reporter "__tank_reporter_$tank_reporter"

  if test $example_status -gt 0
    set __tank_failures (math $__tank_failures + 1)
  end

  function __tank_reporter_quiet; end

  if not functions -q $reporter
    set reporter __tank_reporter_dots
  end

  eval "$reporter $example_status '$example_description'"
end

function __tank_example_description
  functions $argv[1] | grep -v '^$' | head -n 1 | sed -E "s|.*'(.*)'.*|\1|"
end
