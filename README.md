*NOTE:* This repository is intended to be used for my personal
training to be familiar with using git and GitHub.

# Kodougu

[![Build Status](https://github.com/mnbi/kodougu/workflows/Build/badge.svg)](https://github.com/mnbi/kodougu/actions?query=workflow%3A"Build")

The word, "kodougu" means small tools in Japanese.

## Installation

At first, build the gem package like these commands:

    $ bundle install
    $ rake build

Now, the new gem made in the `pkg` directory.  Install it as:

    $ gem install pkg/kodougu-0.2.0.gem

## Known Issues

Some tests fails during Travis CI build process when no OS type is
specified.  In the build log, the default OS to build is Linux.  On
the other hand, I use macOS High Sierra (10.13.6).  In my environment,
all tests have passed.

To avoid build failure, I put a line to specify OS type into `.travis.yml`.

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mnbi/kodougu.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

