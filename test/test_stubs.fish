function suite_stubs
	function setup
		function dummy
			echo original
		end

		set -g dummy original
	end

	function teardown
		set -ge dummy
		functions -e dummy
	end

	function test_function_stubbing
		assert_equal original (dummy)

		function dummy_stub
			echo stubbed
		end
		stub dummy dummy_stub
		assert_equal stubbed (dummy)

		unstub dummy
		assert_equal original (dummy)
		refute (functions -q dummy_stub)
	end

	function test_function_stubbing_without_original
		function dummy_stub
			echo stubbed
		end
		stub dummy dummy_stub
		assert_equal stubbed (dummy)
	end

	function test_variable_stubbing
		assert_equal original $dummy

		stub_var dummy stubbed
		assert_equal stubbed $dummy

		unstub_var dummy
		assert_equal original $dummy
	end

	function test_variable_stubbing_without_original
		stub_var unknown stubbed
		assert_equal stubbed "$unknown"
	end

	function test_stub_teardown
		stub_var dummy stubbed

		function dummy_stub
			echo stubbed
		end
		stub dummy dummy_stub

		emit test_unstub

		assert_equal original (dummy)
		refute (functions -q dummy_stub)
		assert_equal original $dummy
	end

	function test_directory_stubbing
		set -l dirname (stub_dir)
		assert (test -d $dirname)

		emit test_unstub

		refute (test -d $dirname)
	end

	function test_directory_stubbing_with_explicit_name
		set -l dirname (stub_dir stubbed)
		assert (test -d $dirname)
		assert_equal stubbed (basename $dirname)

		emit test_unstub

		refute (test -d $dirname)
	end

	function test_file_stubbing
		set -l filename (stub_file)
		assert (test -f $filename)

		emit test_unstub

		refute (test -f $filename)
	end

	function test_file_stubbing_with_explicit_name
		set -l filename (stub_file stubbed)
		assert (test -f $filename)
		assert_equal stubbed (basename $filename)

		emit test_unstub

		refute (test -f $filename)
	end
end

if not set -q tank_running
	source (dirname (status -f))/helper.fish
	tank_run
end
