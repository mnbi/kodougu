# -*- coding: utf-8 -*-
# :markdown:

require 'open3'
require 'test_helper'

class CountlinesTest < Minitest::Test
  CL_NAME = 'countlines'
  EXE_PATH = File.expand_path('../exe', __dir__)
  CL_PATH = File.join(EXE_PATH, CL_NAME)
  BUNDLE_EXEC = "bundle exec \'#{CL_PATH}\'"

  FIXTURE_PATH = File.expand_path('fixture', __dir__)

  def test_that_it_puts_a_message_to_stderr_when_no_argument_is_specified
    cmd = "#{BUNDLE_EXEC}"
    oe_str, status = Open3.capture2e(cmd)
    assert_equal 1, status.exitstatus
    assert_equal 'No type is specified.', oe_str.chomp
  end

  def test_that_it_prints_version
    cmd = "#{BUNDLE_EXEC} -V"
    pattern = Regexp.new("#{CL_NAME} version \\d+\\.\\d+\\.\\d+ \\(kodougu #{Kodougu::VERSION}\\)")
    oe_str, status = Open3.capture2e(cmd)
    assert_equal 0, status.exitstatus
    assert_match pattern, oe_str.chomp
  end

  def test_that_it_prints_help_message
    cmd = "#{BUNDLE_EXEC} -h"
    oe_str, status = Open3.capture2e(cmd)
    assert_equal 0, status.exitstatus

    help_message = oe_str.split("\n")
    pattern = Regexp.new("Usage: #{CL_NAME}")
    assert_match pattern, help_message.first
  end

  def test_that_it_scucceeds_to_count_1_line_file
    one_dir = File.join(FIXTURE_PATH, '1')
    cmd = "#{BUNDLE_EXEC} -d \'#{one_dir}\' txt "
    o_str, status = Open3.capture2(cmd)
    assert_equal 0, status.exitstatus

    pattern = Regexp.new("Total: 1 lines")
    output = o_str.split("\n")
    assert_match pattern, output[1]
  end

  def test_that_it_succeeds_to_count_files_under_the_target_directory
    five_dir = File.join(FIXTURE_PATH, '5')
    cmd = "#{BUNDLE_EXEC} -d \'#{five_dir}\' txt "
    o_str, status = Open3.capture2(cmd)
    assert_equal 0, status.exitstatus

    pattern = Regexp.new("Total: 10 lines")
    output = o_str.split("\n")
    assert_match pattern, output[1]
  end

  def test_that_it_can_handle_multiple_types
    mix_dir = File.join(FIXTURE_PATH, 'mix')
    cmd = "#{BUNDLE_EXEC} -d \'#{mix_dir}\' txt md html"
    o_str, status = Open3.capture2(cmd)
    assert_equal 0, status.exitstatus

    pattern = Regexp.new("Total: 15 lines")
    output = o_str.split("\n")
    assert_match pattern, output[1]
  end
end
