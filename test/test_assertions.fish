function suite_assertions
  function test_assert
    assert (true)
  end

  function test_assert_empty
    assert_empty
  end

  function test_assert_equal
    assert_equal foo foo
  end

  function test_assert_includes
    assert_includes foo bar foo moo
  end

  function test_assert_match
    assert_match '^he..o$' hello
  end

  function test_refute
    refute (false)
  end

  function test_refute_equal
    refute_equal foo bar
  end

  function test_refute_includes
    refute_includes foo bar moo zoo
  end

  function test_refute_match
    refute_match '^o..eh$' hello
  end
end

if not set -q tank_running
  source (dirname (status -f))/helper.fish
  tank_run
end
