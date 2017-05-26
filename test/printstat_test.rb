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

  def test_that_it_correctly_prints_stats_of_sample_dat
    sample_file = File.expand_path('sample.dat', FIXTURE_PATH)
    cmd = "#{BUNDLE_EXEC} \'#{sample_file}\'"
    o_str, status = Open3.capture2(cmd)
    assert_equal 0, status.exitstatus
    results = make_hash(o_str)
    st = File::Stat.new(sample_file)
    %i[atime mtime ctime birthtime size].each do |sym|
      if st.respond_to?(sym)
        assert_equal results[sym], st.public_send(sym).to_s
      end
    end
  end

  private
  def make_hash(str)
    lines = str.split("\n")[1..-1] # ignore the 1st line of the output
    pairs = lines.map do |l|
      md = l.match(/\A\s*([^:]+):\s(.*)\z/)
      [md[1], md[2]]
    end
    pairs.reduce({}) do |r, pair|
      k = pair.first.lstrip.intern
      r.update(k => pair.last)
    end
  end
end
