# Shottur

Watches for new screenshots, uploads them to Imgur, and copies the URL to the clipboard.

Currently:

- Only works on OS X
- Will try to upload all new files in watching directory
- Requires [terminal-notifier](https://github.com/julienXX/terminal-notifier) to be available on PATH.


## Installation

As a gem:

    $ gem install shottur

## Usage

    $ shottur --dir <screnshot-dir> --imgur-client-id <imgur-client-id>


## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `rake test` to run the tests.

## Contributing

Bug reports and pull requests are welcome.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

