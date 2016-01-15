require 'test_helper'

describe Shottur::Uploader do
  let(:path) { '/path/to/some/image.png' }
  let(:url) { 'http://example.com/image.png' }

  subject do
    Shottur::Uploader.new(path, 'clientid').tap do |u|
      def u.do_upload!
        @uploaded_image = OpenStruct.new(link: 'http://example.com/image.png')
      end
    end
  end

  describe 'before the image has been uploaded' do
    describe '#upload' do
      it('returns false') { assert(subject.uploaded? == false) }
    end

    describe '#uploaded_url' do
      it('returns nil') { assert(subject.uploaded_url.nil?) }
    end
  end

  describe 'after the image has been uploaded' do
    before { subject.upload! }

    describe '#upload' do
      it('returns true') { assert(subject.uploaded?) }
    end

    describe '#uploaded_url' do
      it('returns the url') do
        assert(subject.uploaded_url == 'http://example.com/image.png')
      end
    end
  end
end
