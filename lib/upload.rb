require 'trollop'
require 'shottur'

opts = Trollop.options do
  opt(:file, "Path to file to upload",
      type: :string, required: true)
  opt(:imgur_client_id, "Imgur client id to use when uploading",
      type: :string, required: true)
end

puts "Uploading #{opts[:file]}..."
uploader = Shottur::Uploader.new(opts[:file], opts[:imgur_client_id])
uploader.upload!

Shottur.notify(
  title:         'Screenshot Uploaded',
  subtitle:      uploader.uploaded_url,
  message:       'Click to copy URL',
  content_image: uploader.uploaded_url,
  sound:         'Glass',
  execute:       "echo '#{uploader.uploaded_url}' | tr -d '\n' | pbcopy"
)
