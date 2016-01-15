require 'test_helper'
require 'fileutils'

describe Shottur::Watcher do
  it 'requires a block' do
    assert_raises(ArgumentError) do
      Shottur::Watcher.new('some/path')
    end
  end

  describe 'when files are modified' do
    let(:screenshot_dir) { 'test/screenshots' }

    before { FileUtils.mkdir(screenshot_dir) }
    after { FileUtils.rm_rf(screenshot_dir) }

    it 'calls the callback when a new file is added' do
      stub = OpenStruct.new(new_screenshot?: true)

      Shottur::FoundFile.stub(:new, stub) do
        callback_paths = []

        Thread.new(callback_paths) do
          Shottur::Watcher.new(screenshot_dir) do |path|
            callback_paths << path
          end
        end

        sleep 0.1
        open("#{screenshot_dir}/test_screenshot.png", "w") { |f| f.puts "." }
        sleep 0.5

        assert(callback_paths.length == 1)
      end
    end

    it 'does not call the callback when a file is modified' do
      callback_paths = []

      open("#{screenshot_dir}/test_screenshot.png", "w") { |f| f.puts "." }

      sleep 1

      Thread.new(callback_paths) do
        Shottur::Watcher.new(screenshot_dir) do |path|
          callback_paths << path
        end
      end

      sleep 0.1
      open("#{screenshot_dir}/test_screenshot.png", "w") { |f| f.puts "-" }
      sleep 0.5

      assert(callback_paths.length == 0)
    end
  end
end
