# -*- coding: utf-8 -*-
# :markdown:

module Kodougu; end

class Kodougu::DiffHash
  include Enumerable

  def initialize(a, b)
    @diffs = {}
    compare(a, b)
  end

  def empty?
    @diffs.empty?
  end

  def key?(key)
    @diffs.key?(key)
  end

  def keys
    @diffs.keys
  end

  def [](key)
    @diffs[key]
  end

  def each(&block)
    @diffs.each(&block)
  end

  private
  def compare(a, b)
    a.each do |k, v|
      unless b.key?(k) && b[k] == v
        @diffs[k] = [v, b[k]]
      end
    end
    b.each do |k, v|
      unless a.key?(k) && a[k] == v
        @diffs[k] = [a[k], v]
      end
    end
  end
end
