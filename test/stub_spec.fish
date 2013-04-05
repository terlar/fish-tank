. (dirname (status -f))/helper.fish

function it_returns_command_without_args
  stub dummy_command
  test (dummy_command) = dummy_command
end

function it_mirrors_input
  stub dummy_command
  test (dummy_command -I can mimic) = 'dummy_command -I can mimic'
end

function it_runs_subcommand_with_args_when_defined
  stub dummy_command

  function dummy_command-subcommand
    echo 'I am subcommand with' $argv
  end

  test (dummy_command subcommand args) = 'I am subcommand with args'
end

function it_stubs_multiple_commands
  stub dummy_command1 dummy_command2
  test (dummy_command1) = dummy_command1
  and test (dummy_command2) = dummy_command2
end

. $fish_tank
