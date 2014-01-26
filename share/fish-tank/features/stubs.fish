function stub
  set -l target $argv[1]
  set -l stub $argv[2]
  set -g __tank_stubs $__tank_stubs $target

  if functions -q $target
    if not functions -q __tank_stubs_backup_$target
      functions -c $target __tank_stubs_backup_$target
    end
    functions -e $target
  end

  functions -c $stub $target
  functions -e $stub
end

function stub_var
  set -l target $argv[1]
  set -l stub $argv[2..-1]

  set -g __tank_var_stubs $__tank_var_stubs $target

  if not set -q __tank_var_stubs_backup_$target
    set -g __tank_var_stubs_backup_$target $$target
  end
  set $target $stub
end

# Events
function __tank_test_stub_teardown -e test_finished
  for target in $__tank_stubs
    functions -e $target

    if functions -q __tank_stubs_backup_$target
      functions -c __tank_stubs_backup_$target $target
      functions -e __tank_stubs_backup_$target
    end
  end
  set -e __tank_stubs

  for target in $__tank_var_stubs
    set -l backup __tank_var_stubs_backup_$target
    set $target $$backup
    set -e $backup
  end
  set -e __tank_var_stubs
end
