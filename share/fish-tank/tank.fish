# Fish Tank
set -l tank_path (dirname (status -f))

if not contains $tank_path/functions $fish_function_path
  set fish_function_path $tank_path/functions $fish_function_path
end

source $tank_path/features/assertions.fish
source $tank_path/features/reporting.fish
source $tank_path/features/stubs.fish
