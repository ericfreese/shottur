require 'test_helper'

describe Shottur::FoundFile do
  class SpotlightMock
    def initialize(hash)
      @hash = hash
    end

    def get(k)
      @hash[k]
    end
  end

  subject { Shottur::FoundFile.new('/path/to/some/image.png') }
  let(:spotlight_info) { SpotlightMock.new(spotlight_hash) }

  describe '#new_screenshot?' do
    let(:spotlight_hash) do
      t = Time.now
      { kMDItemIsScreenCapture: true,
        kMDItemDateAdded: t,
        kMDItemContentCreationDate: t }
    end

    describe 'when the file is not a screenshot' do
      let(:spotlight_hash) do
        t = Time.now
        { kMDItemIsScreenCapture: false,
          kMDItemDateAdded: t,
          kMDItemContentCreationDate: t }
      end

      it 'returns false' do
        subject.stub(:spotlight_info, spotlight_info) do
          assert(subject.new_screenshot? == false)
        end
      end
    end

    describe 'when the file is old' do
      let(:spotlight_hash) do
        t = Time.now
        { kMDItemIsScreenCapture: true,
          kMDItemDateAdded: t,
          kMDItemContentCreationDate: t - 1 }
      end

      it 'returns false' do
        subject.stub(:spotlight_info, spotlight_info) do
          assert(subject.new_screenshot? == false)
        end
      end
    end

    describe 'when the file is new and a screenshot' do
      it 'returns true' do
        subject.stub(:spotlight_info, spotlight_info) do
          assert(subject.new_screenshot? == true)
        end
      end
    end
  end
end
