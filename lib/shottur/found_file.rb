require 'spotlight'

module Shottur
  class FoundFile
    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def new_screenshot?
      screenshot? && new?
    end

    private

    def screenshot?
      spotlight_info.get(:kMDItemIsScreenCapture)
    end

    def new?
      time_added == time_created
    end

    def time_added
      spotlight_info.get(:kMDItemDateAdded)
    end

    def time_created
      spotlight_info.get(:kMDItemContentCreationDate)
    end

    def spotlight_info
      @spotlight_info ||= Spotlight::Item.new(file_path)
    end
  end
end
