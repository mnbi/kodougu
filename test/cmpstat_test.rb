# -*- coding: utf-8 -*-
# :markdown:

require 'open3'
require 'test_helper'

class CmpstatTest < Minitest::Test
  CL_NAME = 'cmpstat'
  EXE_PATH = File.expand_path('../exe', __dir__)
  CL_PATH = File.join(EXE_PATH, CL_NAME)
  BUNDLE_EXEC = "bundle exec \'#{CL_PATH}\'"

  FIXTURE_PATH = File.expand_path('fixture', __dir__)

  def test_that_it_puts_usage_with_no_arguments
    cmd = "#{BUNDLE_EXEC}"
    oe_str,  status = Open3.capture2(cmd)
    assert_equal 1, status.exitstatus
    assert_match(/Usage/, oe_str)
  end
end
