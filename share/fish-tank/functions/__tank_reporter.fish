function __tank_reporter
  set -l example_description (__tank_example_description $argv[1])
  set -l reporter "__tank_reporter_$tank_reporter"

  function __tank_reporter_quiet; end

  if not functions -q $reporter
    set reporter __tank_reporter_dots
  end

  eval "$reporter $argv[2] '$example_description'"
end

function __tank_example_description
  set -l name $argv[1]
  set -l description (functions $name | grep -m1 -v '^$' | sed -E "s|.*'(.*)'.*|\1|" | grep -v $name)

  if test -z $description
    set description (echo $name | sed 's|it_||' | tr _ ' ')
  end

  echo $description
end
