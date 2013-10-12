function skip
  emit test_skip $argv
end

function assert
  assert_equal 0 $status
end

function assert_empty
  set -gq __tank_current_test_skip; and return

  if test -z "$argv"
    emit assertion_success
  else
    emit assertion_failure "Expected \"$argv\" to be empty."
  end
end

function assert_equal
  set -gq __tank_current_test_skip; and return
  set -l expected $argv[1]
  set -l actual $argv[2..-1]

  if test "$expected" = "$actual"
    emit assertion_success
  else
    emit assertion_failure "Expected: \"$expected\""\n"  Actual: \"$actual\""
  end
end

function assert_includes
  set -gq __tank_current_test_skip; and return

  set -l item $argv[1]
  set -l list $argv[2..-1]

  if contains "$item" $list
    emit assertion_success
  else
    emit assertion_failure "Expected \"$list\" to include \"$item\""
  end
end

function assert_match
  set -gq __tank_current_test_skip; and return

  set -l pattern $argv[1]
  set -e argv[1]

  if echo $argv | grep $pattern >/dev/null
    emit assertion_success
  else
    emit assertion_failure "Expected \"$pattern\" to match \"$argv\""
  end
end

function refute
  refute_equal 0 $status
end

function refute_empty
  set -gq __tank_current_test_skip; and return

  if test -n "$argv"
    emit assertion_success
  else
    emit assertion_failure 'Expected "" to not be empty.'
  end
end

function refute_equal
  set -gq __tank_current_test_skip; and return
  set -l expected $argv[1]
  set -l actual $argv[2..-1]

  if not test "$expected" = "$actual"
    emit assertion_success
  else
    emit assertion_failure "Expected \"$expected\" to not be equal to \"$actual\""
  end
end

function refute_includes
  set -gq __tank_current_test_skip; and return

  set -l item $argv[1]
  set -l list $argv[2..-1]

  if not contains "$item" $list
    emit assertion_success
  else
    emit assertion_failure "Expected \"$list\" to not include \"$item\""
  end
end

function refute_match
  set -gq __tank_current_test_skip; and return

  set -l pattern $argv[1]
  set -e argv[1]

  if echo $argv | grep -v $pattern >/dev/null
    emit assertion_success
  else
    emit assertion_failure "Expected \"$pattern\" to not match \"$argv\""
  end
end

# Events
function __tank_assertion_failure -e assertion_failure
  set -g __tank_current_test_status 1
  emit test_stop
end
