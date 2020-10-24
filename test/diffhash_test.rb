# -*- coding: utf-8 -*-
# :markdown:

require 'test_helper'

class DiffHashTest < Minitest::Test
  def test_that_empty_hashes_always_has_no_diffs
    diff = Kodougu::DiffHash.new({}, {})
    assert diff.empty?
  end

  def test_that_creates_empty_result_for_same_hashes
    a = Hash(foo: 1, bar: 2,  baz: 3)
    b = Hash(foo: 1, bar: 2,  baz: 3)
    diff = Kodougu::DiffHash.new(a, b)
    assert diff.empty?
  end

  def test_that_compares_a_hash_to_empty
    a = Hash(foo: 1)
    diff = Kodougu::DiffHash.new(a, {})
    refute diff.empty?
  end

  def test_that_compares_empty_to_a_hash
    b = Hash(foo: 1)
    diff = Kodougu::DiffHash.new({}, b)
    refute diff.empty?
  end

  def test_that_it_holds_keys
    a = Hash(foo: 1)
    diff = Kodougu::DiffHash.new(a, {})
    refute diff.empty?
    refute diff.keys.empty?
  end

  def test_that_it_holds_a_key
    a = Hash(foo: 1)
    diff = Kodougu::DiffHash.new(a, {})
    refute diff.empty?
    assert diff.key?(:foo)
    refute diff.key?(:bar)
  end

  def test_that_it_can_be_fetched_difference
    a = Hash(foo: 1)
    diff = Kodougu::DiffHash.new(a, {})
    refute diff.empty?
    assert diff.key?(:foo)

    v = diff[:foo]
    refute v.nil?
    v = diff[:bar]
    assert v.nil?
  end

  def test_that_compares_hashes_those_have_share_all_keys_but_values
    a = Hash(foo: 1, bar: 2, baz: 3)
    b = Hash(foo: 1, bar: 3, baz: 2)
    diff = Kodougu::DiffHash.new(a, b)

    refute diff.empty?
    refute diff.key?(:foo)
    assert diff.key?(:bar)
    assert diff.key?(:baz)

    assert_equal [2, 3], diff[:bar]
    assert_equal [3, 2], diff[:baz]
  end

  def test_that_compares_hashes_those_have_share_keys_partially
    a = Hash(foo: 1, bar: 2, baz: 3)
    b = Hash(foo: 1, bar: 3, hoge: 3)
    diff = Kodougu::DiffHash.new(a, b)

    refute diff.empty?
    refute diff.key?(:foo)
    assert diff.key?(:bar)
    assert diff.key?(:baz)
    assert diff.key?(:hoge)

    assert_equal [2, 3], diff[:bar]
    assert_equal [3, nil], diff[:baz]
    assert_equal [nil, 3], diff[:hoge]
  end

  def test_that_compares_hashes_those_have_complex_values
    a = Hash(foo: 1, bar: [1, 2], baz: [3, 4, 5])
    b = Hash(foo: 1, bar: [2, 1], baz: [3, 4, 5])
    diff = Kodougu::DiffHash.new(a, b)

    refute diff.empty?
    refute diff.key?(:foo)
    assert diff.key?(:bar)
    refute diff.key?(:baz)

    assert_equal [[1, 2], [2, 1]], diff[:bar]
  end

  def test_that_it_is_enumerable
    a = Hash(foo: 1, bar: 2, baz: 3)
    b = Hash(foo: 1, bar: 'apple', baz: 'imac', hoge: 'sierra')
    diff = Kodougu::DiffHash.new(a, b)

    refute diff.empty?
    refute diff.key?(:foo)

    h = {}
    diff.each do |pair|
      h.update(pair.first => pair.last)
    end

    %i[bar baz hoge].each do |sym|
      assert h.key?(sym)
    end

    assert_equal [2, 'apple'], h[:bar]
    assert_equal [3, 'imac'], h[:baz]
    assert_equal [nil, 'sierra'], h[:hoge]
  end
end
