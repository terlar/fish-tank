# Fish Tank
set -l tank_path (dirname (status -f))

if not contains $tank_path/functions $fish_function_path
  set fish_function_path $tank_path/functions $fish_function_path
end

set -gx __tank_examples
set -gx __tank_failures

__tank_fill
__tank_observe

exit
