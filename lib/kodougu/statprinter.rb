# -*- coding: utf-8 -*-
# :markdown:

module Kodougu; end

class Kodougu::StatPrinter
  def initialize(st)
    @st = st
  end

  def dev
    print_hex(@st.dev)
  end

  def mode
    print_oct(@st.mode)
  end

  def nlink
    print_decimal(@st.nlink)
  end

  def ino
    print_decimal(@st.ino)
  end

  def uid
    print_decimal(@st.uid)
  end

  def gid
    print_decimal(@st.gid)
  end

  def rdev
    print_hex(@st.rdev) + " (#{@st.rdev_major},  #{@st.rdev_minor})"
  end

  def atime
    print_time(@st.atime)
  end

  def mtime
    print_time(@st.mtime)
  end

  def ctime
    print_time(@st.ctime)
  end

  def birthtime
    print_time(@st.birthtime)
  end

  def size
    print_decimal(@st.size)
  end

  def blocks
    print_decimal(@st.blocks)
  end

  def blksize
    print_decimal(@st.blksize)
  end

  private
  def print_oct(num)
    "%o" % num
  end

  def print_decimal(num)
    r = ''
    head = num.to_s
    until head.empty?
      tail = head[-3..-1]
      r = tail ? "#{tail},#{r}" : "#{head},#{r}"
      head = head[0..-4]
    end
    r.sub(/,\z/, '')
  end

  def print_hex(num)
    "%x" % num
  end

  def print_time(time)
    time
  end
end
