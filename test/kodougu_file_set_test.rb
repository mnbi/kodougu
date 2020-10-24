require 'test_helper'

class KodouguFileSetTest < Minitest::Test
  FIXTURE_PATH = File.expand_path('fixture', __dir__)

  def test_that_it_can_find_files_those_have_the_specified_ext
    fset = Kodougu::FileSet.new(FIXTURE_PATH)
    names = fset.match(['dat'])
    refute_empty names
  end

  def test_that_it_can_find_files_those_have_one_of_the_specified_exts
    mix_path = [FIXTURE_PATH, 'mix'].join('/')
    fset = Kodougu::FileSet.new(mix_path)
    names = fset.match(['html', 'md'])
    assert_equal 3, names.size
  end

  def test_that_it_can_detect_shellscript_type_of_a_file_without_ext
    no_ext_path = [FIXTURE_PATH, 'no_ext'].join('/')
    fset = Kodougu::FileSet.new(no_ext_path)
    names = fset.match(['sh'])
    assert_equal 3, names.size
  end

  def test_that_it_can_detect_ruby_type_of_a_file_without_ext
    no_ext_path = [FIXTURE_PATH, 'no_ext'].join('/')
    fset = Kodougu::FileSet.new(no_ext_path)
    names = fset.match(['rb'])
    assert_equal 1, names.size
  end

  def test_that_it_can_detect_perl_type_of_a_file_without_ext
    no_ext_path = [FIXTURE_PATH, 'no_ext'].join('/')
    fset = Kodougu::FileSet.new(no_ext_path)
    names = fset.match(['pl'])
    assert_equal 1, names.size
  end

  def test_that_it_can_detect_python_type_of_a_file_without_ext
    no_ext_path = [FIXTURE_PATH, 'no_ext'].join('/')
    fset = Kodougu::FileSet.new(no_ext_path)
    names = fset.match(['py'])
    assert_equal 1, names.size
  end

end
