# -*- coding: utf-8 -*-
# :markdown:

require 'open3'
require 'test_helper'

class PrintstatTest < Test::Unit::TestCase
  CL_NAME = 'printstat'
  EXE_PATH = File.expand_path('../../exe', __FILE__)
  CL_PATH = File.join(EXE_PATH, CL_NAME)
  BUNDLE_EXEC = "bundle exec \'#{CL_PATH}\'"

  FIXTURE_PATH = File.expand_path('../fixture', __FILE__)

  def test_that_it_puts_a_message_on_error
    cmd = "#{BUNDLE_EXEC} foo"
    oe_str, status = Open3.capture2e(cmd)
    assert_equal 1, status.exitstatus
    assert_match(/No such entry/, oe_str.chomp)
  end

  def test_that_it_print_version
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

  def test_that_it_scucceeds_for_fixture_dir
    cmd = "#{BUNDLE_EXEC} \'#{FIXTURE_PATH}\'"
    o_str, status = Open3.capture2(cmd)
    assert_equal 0, status.exitstatus
    assert_false o_str.empty?
  end
end
