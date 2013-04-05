function stub --description 'Replaces a command with a dummy function'
  for command in $argv
    eval 'function '$command'
      if test (count $argv) -eq 0
        echo '$command'
        return
      end

      set -l func_name '$command'-$argv[1]

      if functions -q $func_name
        set -e argv[1]
        eval $func_name $argv
      else
        echo '$command' $argv
      end
    end'
  end
end
