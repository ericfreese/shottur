require 'filewatcher'

module Shottur
  class Watcher
    def initialize(dir)
      raise ArgumentError unless block_given?

      FileWatcher.new(File.expand_path(dir)).watch do |file, event|
        yield file if event == :new && FoundFile.new(file).new_screenshot?
      end
    end
  end
end
