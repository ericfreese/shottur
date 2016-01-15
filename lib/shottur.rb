require 'shottur/version'
require 'shottur/found_file'
require 'shottur/uploader'
require 'shottur/watcher'

module Shottur
  def self.notify(opts)
    command = ["terminal-notifier"]

    opts.each do |h, k|
      opt = h.to_s.gsub(/_([a-z])/) { Regexp.last_match[1].upcase }
      command << %(-#{opt} "#{k.gsub(/"/, '\"')}")
    end

    `#{command.join(' ')}`
  end
end
