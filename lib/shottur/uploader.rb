require 'imgur'

module Shottur
  class Uploader
    def initialize(image_path, client_id)
      @image_path = image_path
      @client_id = client_id
    end

    def upload!
      return if uploaded?

      do_upload!
    end

    def uploaded?
      !uploaded_image.nil?
    end

    def uploaded_url
      uploaded_image.link unless uploaded_image.nil?
    end

    private

    attr_reader :image_path, :client_id
    attr_accessor :uploaded_image

    def client
      @client ||= Imgur::Client.new(client_id)
    end

    def local_image
      @local_image ||= Imgur::LocalImage.new(image_path, title: image_title)
    end

    def image_title
      File.basename(image_path)
    end

    def do_upload!
      @uploaded_image = client.upload(local_image)
    end
  end
end
