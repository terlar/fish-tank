function __tank_report
  set -l example_status $argv[1]
  set -l example_function $argv[2]
  set -l example_description (__tank_example_description $example_function)
  set -l reporter "__tank_reporter_$tank_reporter"

  if test $example_status -gt 0
    set __tank_failures $__tank_failures $example_function
  end

  function __tank_reporter_quiet; end

  if not functions -q $reporter
    set reporter __tank_reporter_dots
  end

  eval "$reporter $example_status '$example_description'"
end

function __tank_example_description
  set -l name $argv[1]
  set -l description (functions $name | grep -m1 -v '^$' | sed -E "s|.*'(.*)'.*|\1|" | grep -v $name)

  if test -z $description
    set description (echo $name | sed 's|it_||' | tr _ ' ')
  end

  echo $description
end
