require 'open3'

module Kodougu
  class FileSet
    FILE_CMD = [
      '/usr/local/bin/file',
      '/usr/bin/file'
    ].find {|p| File.exist?(p) }

    def initialize(top_path)
      names = Dir.chdir(top_path) { Dir.glob('**/*') }
      @files = {}

      names.each { |n|
        abs = File.expand_path(n, top_path)
        # skip a name if it represents a directory
        next if FileTest.directory?(abs)
        ext = File.extname(n).delete_prefix('.')
        ext = :no_ext if ext.empty?
        if @files.key?(ext)
          @files[ext].push(abs)
        else
          @files[ext] = [abs]
        end
      }
    end

    def match(exts)
      results = []
      exts.each { |e| results += Array(@files[e]) }
      results += check_type(@files[:no_ext], exts)
      results
    end

    private
    def check_type(files, exts)
      return [] if files.nil? || files.empty?

      results = []
      output = []

      Open3.pipeline_rw([FILE_CMD, '--mime-type', '-f', '-']) { |i, o, t|
        i.puts(files.join("\n"))
        i.close
        output = o.readlines
        t.join
      }

      output.each { |str|
        path, mtype = str.chomp.split(/:\s+/)
        results.push(path) if ext_match?(mtype, exts)
      }
      results
    end

    EXTS_MAP = {
      :awk => ['awk'],
      :shellscript => ['sh'],
      :perl => ['pl'],
      :python => ['py'],
      :ruby => ['rb']
    }

    def ext_match?(mtype, exts)
      sub = mtype.split('/')[1]
      md = /^x-([\w-]+)/.match(sub)
      return false unless md

      exec_lang = md[1].to_sym
      return false if EXTS_MAP[exec_lang].nil?
      !exts.intersection(EXTS_MAP[exec_lang]).empty?
    end
  end
end
